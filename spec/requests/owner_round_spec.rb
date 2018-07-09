# frozen_string_literal: true

require 'rails_helper'

describe 'owner' do
  let(:owner) { create(:owner) }
  let(:tournament) { create(:tournament_with_teams, team_count: 16, owner: owner) }

  before :each do
    sign_in owner
    owner.add_role(:owner, tournament)
  end

  it 'is allowed rounds#create' do

    expect do
      post tournament_rounds_path(tournament)
    end.to change(Round, :count).by(1)
               .and change(Table, :count).by(8)
                        .and change(Score, :count).by(16)
  end
end
