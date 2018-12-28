require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'account_activation' do
    #let(:mail) { UserMailer.account_activation }

    before :each do
      @user = FactoryBot.create(:user)

    it 'renders the headers' do
      mail = UserMailer.account_activation(@user)
      expect(mail.subject).to eq('Account Activation')
      expect(mail.to).to eq([@user.eamil])
      expect(mail.from).to eq(['lali20021@gmail.com'])
    end

    it 'renders the body' do
      mail = UserMailer.account_activation(@user)
      expect(mail.body.encoded).to match('Hello')
    end
  end
end

  describe 'password_reset' do
    before :each do
      @user = FactoryBot.create(:user)
    end



    it 'renders the headers' do
      @user.reset_token = User.new_token
      mail = UserMailer.password_reset(@user)
      expect(mail.subject).to eq('Password reset')
      expect(mail.to).to eq([@user.email])
      expect(mail.from).to eq(['lali20021@gmail.com'])
    end

    it 'renders the body' do
      @user.reset_token = User.new_token
      mail = UserMailer.password_reset(@user)
      expect(mail.body.encoded).to match('Hello')
    end
  end

end
