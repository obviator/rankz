
class Team < ApplicationRecord
  belongs_to :tournament
  belongs_to :race

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: { scope: :tournament }
  validates :tournament_id, presence: true
  # validates :race_id, presence: true

  def active?
    active&.positive?
  end

  def races
    tournament.races.where("COALESCE(active,0) > 0")
  end
end
