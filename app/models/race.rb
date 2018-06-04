class Race < ApplicationRecord
  belongs_to :tournament
  has_many :teams

  validates :name, presence: true, length: {minimum: 2, maximum: 20}, uniqueness: {scope: :tournament}
  validates :tournament_id, presence: true
end
