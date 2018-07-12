class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  TIEBREAKERS = %w[total_score opponent_score tf ta tn cf ca cn].freeze
end
