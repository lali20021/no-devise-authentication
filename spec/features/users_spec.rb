require 'rails_helper'
require 'session_helper'
require 'capybara/rails'

feature 'User Account' do
  include SessionHelper
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:admin) { FactoryBot.create(:user) }
  let(:non_admin) { FactoryBot.create(:other_user) }

  scenario 'new user sign up' do
    sign_up
    #expect(page).to have_content('User was successfully created.')
    #save_and_open_page
  end

  scenario 'registered user Log in' do
    log_in(admin)
    expect(page).to have_content('You are now logged in.')
    expect(current_path).to eq user_path(admin)
    within 'h1' do
      expect(page).to have_content(admin.first_name + ' ' + admin.last_name)
    end
   end

   scenario 'user Log Out' do
    log_in(admin)
    click_link 'Account'
    click_link 'Log Out'
    expect(current_path).to eq root_path
    expect(page).to have_content('You are now logged out.')
    click_link 'Log In'
   end

   scenario 'index admin user' do
      log_in(admin)
      visit users_path
      expect(users_path).to eq('/users')
      page.has_css?('div.pagination.pagination')
      first_page_of_users = User.paginate(page: 1)
      first_page_of_users.each do |user|
        page.has_css?("td>a[href='#{user_path(user)}']", text: user.last_name)
        expect(page).to have_content('Delete')
      end
  end

  scenario 'index non_admin users' do
    log_in(other_user)
    visit users_path
    expect(page).not_to have_content('Delete')
  end
end
