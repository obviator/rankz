# frozen_string_literal: true

require 'rails_helper'

describe 'owner' do

  describe 'test' do
    it 'is allowed rounds#create' do
      owner = create(:owner)
      tournament = create(:tournament, owner: owner)

      create_list(:team, 16, tournament: tournament)
      sign_in owner

      expect do
        post tournament_rounds_path(tournament)
      end.to change(Round, :count).by(1)
                 .and change(Table, :count).by(8)
                          .and change(Score, :count).by(16)
    end
  end
end
