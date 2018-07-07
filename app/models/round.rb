# frozen_string_literal: true

class Round < ApplicationRecord
  belongs_to :tournament
  has_many :tables, dependent: :destroy
  has_many :tables, dependent: :destroy, inverse_of: :round
  after_create :populate

  delegate :wincalc, :concedecalc, :losecalc, :drawcalc, to: :tournament, allow_nil: true
  delegate :start_date, :end_date, to: :tournament
  delegate :active_teams, to: :tournament
  acts_as_list scope: :tournament

  validate :even_teams?
  validate :all_rounds_complete?, on: :create

  def complete?
    return false unless tables.any?
    tables.each do |table|
      return false unless table.complete?
    end
    true
  end

  def self.all_complete?(tournament:)
    where('tournament_id = ?', tournament).all.each do |round|
      return false unless round.complete?
    end
    true
  end

  def self.any_complete?(tournament:)
    where('tournament_id = ?', tournament).all.each do |round|
      return true if round.complete?
    end
    false
  end

  private

  def even_teams?
    if tournament.active_teams.count.odd?
      errors.add(tournament.name, 'has an odd number of active teams.')
    end
  end

  def all_rounds_complete?
    errors.add(tournament.name, 'has incomplete rounds.') unless Round.all_complete?(tournament: tournament)
  end

  def populate
    table = Table.new
    active_teams.sorted.each_with_index do |team, i|
      table = Table.new if i.even?
      table.round = self
      throw :abort unless table.save
      score = Score.new(table: table, team: team)
      throw :abort unless score.save
    end
  end
end
