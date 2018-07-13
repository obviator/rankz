# frozen_string_literal: true

module TournamentsHelper

  def tiebreaker_list(tournament: nil)
    tiebreaker_list = []
    tiebreakers = Tournament::TIEBREAKERS - (tournament.try(:tiebreaker) || [])
    tiebreakers.each do |tie|
      value = I18n.t "tournaments.edit.tiebreakers.#{tie}", default: tie
      tiebreaker_list << [value, tie]
    end
    tiebreaker_list
  end

end
