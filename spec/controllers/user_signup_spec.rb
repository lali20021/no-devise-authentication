require 'rails_helper'

describe UsersController, type: :controller do
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves new user in the database' do
        expect {
          process :create, method: :post, params: {user: FactoryBot.attributes_for(:user)}
        }.to change(User, :count).by(1)
      end

      it 'redirects to users/show' do
        process :create, method: :post, params: {user: FactoryBot.attributes_for(:user)}
        expect(:user).to redirect_to user_path(assigns[:user])
      end
    end
  end
end

describe UsersController, type: :controller do
  describe 'POST #create' do
    context 'with invalid attributes' do
      it 'does not save new user in the database' do
        expect {
          process :create, method: :post, params: {user: FactoryBot.attributes_for(:invalid_user)}
        }.not_to change(User, :count)
      end

      it "render 'new' template" do
        process :create, method: :post, params: {user: FactoryBot.attributes_for(:invalid_user)}
        expect(response).to render_template :new
      end
    end
  end
end
