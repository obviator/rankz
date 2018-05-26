
class Tournament < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :slug, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :name,
      [:name, '-1'],
      [:name, '-2'],
      [:name, '-3'],
      [:name, :start_date]
    ]
  end


  def self.list
    Tournament.where('active >= ?', 0).order('start_date').all
  end
end
