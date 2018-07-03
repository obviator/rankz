# frozen_string_literal: true

require 'rails_helper'

describe 'user' do
  before(:all) do
    @user = create(:user)
  end
  before(:each) do
    sign_in @user
  end
  it 'is allowed tournaments#new' do
    get new_tournament_path
    expect(response).to be_successful
    # expect(response).to render_template('tournament/new')
  end

  let(:tournament_attributes) { FactoryBot.attributes_for(:tournament) }

  it 'is allowed tournaments#create' do
    expect do
      post tournaments_path, params: { tournament: tournament_attributes }
    end.to change(Tournament, :count).by(1)

    # expect(response).to redirect_to new_user_session_url
  end
end
