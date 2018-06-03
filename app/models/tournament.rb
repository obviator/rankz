
class Tournament < ApplicationRecord
  resourcify

  has_many :teams
  has_many :races

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :slug, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :name,
      [:name, :start_date.strftime('%y')],
      [:name, :start_date.strftime('%Y')],
      [:name, :start_date.strftime('%y-%m-%d')],
      [:name, :start_date]
    ]
  end


  def self.list
    Tournament.where('active >= ?', 0).order('start_date').all
  end
end
