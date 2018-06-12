class Round < ApplicationRecord
  belongs_to :tournament
  acts_as_list scope: :tournament
end
