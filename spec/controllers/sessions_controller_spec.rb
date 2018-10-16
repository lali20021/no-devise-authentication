require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the session and current user' do
      delete :destroy
      expect(controller.current_user).to be nil
    end
  end 
end
