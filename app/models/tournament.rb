# frozen_string_literal: true

class Tournament < ApplicationRecord
  has_many :teams
  has_many :races
  has_many :rounds

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

  validate :lock_calcs

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def self.list
    Tournament.where('COALESCE(active,0) > ?', 0).order('start_date')
  end

  def active_races
    races.where('COALESCE(active,0) > ?', 0)
  end

  def active_teams
    teams.where('COALESCE(active,0) > ?', 0)
  end

  # protected

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
      return role.users.first if role.name = 'owner'
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
end
