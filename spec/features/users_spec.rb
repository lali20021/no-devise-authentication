require 'rails_helper'
require 'session_helper'
require 'capybara/rails'

feature 'User Account' do
  include SessionHelper
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:other_user) }
  let(:admin) { FactoryBot.create(:admin) }
  #let(:non_admin) { FactoryBot.create(:other_user) }

  scenario 'new user sign up' do
    sign_up
    expect(page).to have_content('Please check your email to activate your account.')
    #save_and_open_page
  end

  scenario 'new user activates his account' do
    expect(user.activated?).to be false
    visit edit_account_activation_path(user.activation_token, email: user.email)
    user.reload.activated?
    expect(page).to have_content('Your account has been activated.')
   end

   scenario 'new user has invalid token' do
     visit edit_account_activation_path('invalid token', email: user.email)
     expect(user.reload).not_to be log_in(user)
   end

   scenario 'new user has invalid email' do
     visit edit_account_activation_path(user.activation_token, email: 'wrong')
     expect(user.reload).not_to be log_in(user)
   end

   scenario 'user signs in, but the account is not activated' do
     log_in(user)
     expect(page).to have_content('Account was not activated.')
   end

   scenario 'user logs in' do
     log_in(other_user)
     expect(page).to have_content('You are now logged in.')
     visit user_path(other_user)
     within 'h1' do
       expect(page).to have_content(other_user.first_name + ' ' + other_user.last_name)
     end
   end

   scenario 'user logs out' do
     log_in(other_user)
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
