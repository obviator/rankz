# frozen_string_literal: true

require 'rails_helper'

describe 'Guest' do
  it 'is denied tournaments#new' do
    get new_tournament_path
    expect(response).to redirect_to new_user_session_url
  end

  let(:tournament_attributes) { FactoryBot.attributes_for(:tournament) }

  it 'is denied tournaments#create' do
    expect do
      post tournaments_path, params: { tournament: tournament_attributes }
    end.to_not change(Tournament, :count)

    expect(response).to redirect_to new_user_session_url
  end
end
