require 'rails_helper'

feature 'Admin creates product' do
  given!(:tournament) { build(:tournament) }
  given!(:admin) { create(:admin) }

  scenario 'with valid input', js: true do
    sign_in admin
    visit new_tournament_path
    fill_in 'tournament[name]', with: tournament.name
    fill_in 'tournament[start_date]', with: tournament.start_date
    fill_in 'tournament[end_date]', with: tournament.end_date
    fill_in 'tournament[wincalc]', with: tournament.wincalc
    fill_in 'tournament[drawcalc]', with: tournament.drawcalc
    fill_in 'tournament[losecalc]', with: tournament.losecalc
    fill_in 'tournament[concedecalc]', with: tournament.concedecalc
    click_button 'Create Tournament'
    expect(page).to have_content 'Tournament was successfully created.'
  end
  scenario 'with invalid input', js: true do
    sign_in admin
    visit new_tournament_path
    fill_in 'tournament[name]', with: tournament.name
    fill_in 'tournament[start_date]', with: tournament.start_date
    fill_in 'tournament[end_date]', with: tournament.end_date
    # fill_in 'tournament[wincalc]', with: tournament.wincalc
    fill_in 'tournament[drawcalc]', with: tournament.drawcalc
    fill_in 'tournament[losecalc]', with: tournament.losecalc
    fill_in 'tournament[concedecalc]', with: tournament.concedecalc
    click_button 'Create Tournament'
    expect(page).to have_content 'The tournament could not be saved due to the following error'
    expect(page).to have_content "Can't be blank"
  end


end