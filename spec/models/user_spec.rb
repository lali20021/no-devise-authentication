require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    before do
      @user = User.create(first_name: 'l1', last_name: 'g1', email: 'lali@hotmail.com')
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
      @user.first_name = 'a' * 25
      expect(@user).not_to be_valid
    end




  end
end
