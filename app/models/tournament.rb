class Tournament < ApplicationRecord
  resourcify

  has_many :teams
  has_many :races
  has_many :rounds

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :slug, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
        :name,
        [:name, self.start_date.strftime('%y')],
        [:name, self.start_date.strftime('%Y')],
        [:name, self.start_date.strftime('%y-%m-%d')],
        [:name, self.start_date]
    ]
  end

  def self.list
    Tournament.where('COALESCE(active,0) > ?', 0).order('start_date')
  end

  def races!
    races.where('COALESCE(active,0) > ?', 0)
  end

  def teams!
    teams.where('COALESCE(active,0) > ?', 0)
  end
end
