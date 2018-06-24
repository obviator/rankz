require 'rails_helper'

feature 'Admin creates product' do
  given!(:tournament) { build(:tournament) }
  given!(:admin) { create(:admin) }

  scenario 'with valid input', js: true do
    sign_in admin
    visit new_tournament_path
    fill_in 'Name', with: tournament.name
    fill_in 'Start date', with: tournament.start_date
    fill_in 'End date', with: tournament.end_date
    fill_in 'Win', with: tournament.wincalc
    fill_in 'Draw', with: tournament.drawcalc
    fill_in 'Loss', with: tournament.losecalc
    fill_in 'Concede', with: tournament.concedecalc
    click_button 'Create Tournament'
    expect(page).to have_content 'Tournament was successfully created.'
  end

  # scenario 'with invalid input', js: true do
  #   visit admin_products_path
  #   click_link 'New Product'
  #   click_button 'Create Product'
  #   expect(page).to have_content 'There was an error creating the product'
  # end
end