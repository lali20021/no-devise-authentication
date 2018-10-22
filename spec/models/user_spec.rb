require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    before do
      @user = User.create(first_name: 'l1', last_name: 'g1', email: 'lali@hotmail.com',
      password: 'password', password_confirmation: 'password')
    end

    it 'can be created' do
      expect(@user).to be_valid
    end

    it 'cannot be created without a first name' do
      @user.first_name = nil
      expect(@user).not_to be_valid
    end

    it 'cannot be created without a last first name' do
      @user.last_name = nil
      expect(@user).not_to be_valid
    end

    it 'cannot be created without an email' do
      @user.email = nil
      expect(@user).not_to be_valid
    end

    it 'first name cannot be too short' do
      @user.first_name = 'a' * 1
      expect(@user).not_to be_valid
    end

    it 'first name cannot be too long' do
      @user.first_name = 'a' * 35
      expect(@user).not_to be_valid
    end

    it 'email cannot be invalid' do
      invalid_addresses = %w[user@example,com user_at_bla.org user.name@example. bla@bla_bla.com bla@bla+bla.com]

      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end

    it 'must have a unique email address' do
      @user = User.new(first_name: 'l2', last_name: 'g2', email: 'Lali@hotmail.com')
      expect(@user).not_to be_valid
    end

    it 'password cannot be blank' do
      @user.password = @user.password_confirmation = ' ' * 6
      expect(@user).not_to be_valid
    end

    it 'password has to meet minimum length requirements' do
      @user.password = @user.password_confirmation = 'a' * 5
      expect(@user).not_to be_valid
    end

    it 'should return false for a user with nil digest' do
      expect(@user).not_to be_valid if @user.authenticated?(:remember, ' ')
    end
  end
end
