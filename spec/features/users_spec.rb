require 'rails_helper'
require 'session_helper'
require 'capybara/rails'

feature 'User Account' do
  include SessionHelper
  let(:user) { FactoryBot.create(:user) }

  scenario 'new user sign up' do
    sign_up
    expect(page).to have_content('User was successfully created.')
  end

  scenario 'user Log in' do
    log_in
    expect(page).to have_content('You are now logged in.')
    expect(current_path).to eq user_path(user)
    within 'h1' do
      expect(page).to have_content(user.first_name + ' ' + user.last_name)
    end
   end

   scenario 'user Log Out' do
    log_in
    click_link 'Account'
    click_link 'Log Out'
    expect(current_path).to eq root_path
    expect(page).to have_content('You are now logged out.')
   end
end
