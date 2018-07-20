# frozen_string_literal: true

class Tournament < ApplicationRecord
  TIEBREAKERS ||= %w[total_score opponent_score tf ta tn cf ca cn].freeze

  has_many :teams, dependent: :restrict_with_error
  has_many :races, dependent: :destroy
  has_many :rounds, dependent: :restrict_with_error

  before_validation :default_races

  scope :active, -> { where('COALESCE(active,0) > ?', 0) }
  scope :inactive, -> { where('COALESCE(active,0) = ?', 0) }
  scope :default, -> { where('COALESCE(active,0) = ?', -1) }
  scope :current, -> { where('COALESCE(end_date, start_date) >= ?', Date.today) }
  scope :old, -> { where('COALESCE(end_date, start_date) < ?', Date.today) }

  serialize :tiebreaker, Array

  resourcify

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :slug, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :start_date, presence: true
  validates :wincalc, presence: true
  validates :drawcalc, presence: true
  validates :losecalc, presence: true
  validates :concedecalc, presence: true

  validate :start_date_in_future, on: :create
  validate :end_after_start
  validate :must_have_owner, on: :update

  validate :tiebreaker_whitelist

  validate :lock_calcs

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def tiebreaker=(value)
    super(value & TIEBREAKERS)
  end

  def sorted_teams
    obj = teams.active.shuffle
    tiebreaker.reverse.each do |metric|
      obj = obj.sort_by { |team| [team.send(metric), obj.find_index(team)] }
    end
    obj.reverse
  end

  def user_is_to?
    return false unless user_signed_in?
    return true if current_user.has_role? :admin
    return true if current_user.has_role? :to, self
    false
  end

  def user_is_ato?
    return true if current_user.has_role? :admin
    return true if current_user.has_role? :to, self
    return true if current_user.has_role? :ato, self
    false
  end

  def owner=(user)
    clear_owner
    user.add_role(:owner, self) if user.respond_to?(:has_role?)
  end

  def owner
    roles.each do |role|
      return role.users.first if role.name == 'owner'
    end
    nil
  end

  private

  def clear_owner
    roles.where(name: 'owner').each do |role|
      role.users.each do |usr|
        usr.remove_role(:owner, self)
      end
    end
  end

  def lock_calcs
    if calcs_changed? && Round.any_complete?(tournament: self)
      errors.add(:name, 'cannot change calcs once in use.')
    end
  end

  def calcs_changed?
    wincalc_changed? || \
      losecalc_changed? || \
      drawcalc_changed? || \
      concedecalc_changed?
  end

  def start_date_in_future
    errors.add :start_date, 'Cannot be in the past.' \
    if (start_date || Date.tomorrow) < Date.today
  end

  def end_after_start
    return if end_date.nil?
    if end_date < (start_date || Date.tomorrow)
      errors.add(:end_date, 'cannot be before start.')
    end
  end

  def slug_candidates
    [
        :name,
        [:name, start_date.strftime('%y')],
        [:name, start_date.strftime('%Y')],
        [:name, start_date.strftime('%y-%m-%d')],
        [:name, start_date]
    ]
  end

  def must_have_owner
    errors.add(:owner, 'must exist.') if owner.nil?
  end

  def tiebreaker_whitelist
    errors.add(:tiebreaker, 'violates whitelist.') unless tiebreaker & TIEBREAKERS == tiebreaker
  end

  def default_races
    Tournament.where(active: -1).first.races.each do |drace|
      new_race = drace.dup
      new_race.tournament = self
      new_race.save
    end
  end
end
