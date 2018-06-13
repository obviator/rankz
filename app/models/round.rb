class Round < ApplicationRecord
  belongs_to :tournament
  acts_as_list scope: :tournament

  validate :even_teams,
           :previous_rounds_complete

  def even_teams
    if tournament.teams!.count.odd?
      errors.add(tournament.name, 'has an odd number of active teams.')
    end
  end

  def previous_rounds_complete
    if false
      errors.add(tournament.name, 'has an incomplete round')
    end
  end
end
