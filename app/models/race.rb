class Race < ApplicationRecord
  belongs_to :tournament
  has_many :teams
end
