require 'rails_helper'
require 'capybara/rails'
module SessionHelper

  def sign_up
    visit root_path
    click_link 'Log In'
    click_link 'Sign Up Now'
    fill_in 'First name', with: 'Jon'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Email', with: 'jon@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Create User'
  end

  def log_in
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'
  end

end
