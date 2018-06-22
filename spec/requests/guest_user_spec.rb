require "rails_helper"

describe 'Guest access' do
  it 'denied access tournaments#new' do
    get new_tournament_path
    expect(response).to redirect_to new_user_session_url
  end

  let(:tournament_attributes) { FactoryBot.attributes_for(:tournament) }

  it 'denied access tournaments#create' do
    expect {
      post tournaments_path, params: { tournament: tournament_attributes }
    }.to_not change(Tournament, :count)

    expect(response).to redirect_to new_user_session_url
  end
end