require 'rails_helper'


describe UsersController, type: :controller do
  describe 'GET #edit, PATCH #update' do

    before :each do
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:other_user)
    end

    context 'valid attributes' do

      it 'assigns the requested user to @user' do
        log_in_as(@user)
        # get :edit, id: @user, user: FactoryBot.attributes_for(:user)
        get :edit, params: {id: @user, user: FactoryBot.attributes_for(:user)}
        expect(assigns(:user)).to eq(@user)
      end

      it 'locates the requested @user' do
        log_in_as(@user)

        # patch :update, id: @user, user: FactoryBot.attributes_for(:user)
        process :update, method: :patch, params: {id: @user, user: FactoryBot.attributes_for(:user)}
        expect(assigns(:user)).to eq(@user)
      end

      it "changes @user's attributes" do
        log_in_as(@user)
        # patch :update, id: @user, user: FactoryBot.attributes_for(:user, first_name: ' ', last_name: ' ')
        process :update, method: :patch, params: {id: @user, user: FactoryBot.attributes_for(:user, first_name: 'Racheal', last_name: 'Walker')}
        @user.reload
        expect(@user.first_name).to eq('Racheal')
        expect(@user.last_name).to eq('Walker')
      end
    end

    context 'only a logged user can edit and update' do

      it 'redirects edit when not logged in' do
          get :edit, params: {id: @user, user: FactoryBot.attributes_for(:user)}
          edit_user_path(@user)
          expect(flash[:danger]).not_to be_nil
          expect(@user).to redirect_to login_url
      end

      it 'redirects update when not logged in' do
          process :update, method: :patch, params: {id: @user, user: FactoryBot.attributes_for(:user)}
          expect(flash[:danger]).not_to be_nil
          expect(@user).to redirect_to login_url
      end
    end

    context 'only the legitimate user can edit and update' do

      it 'redirect edit when logged in as a wrong user' do
        log_in_as(@other_user)
        get :edit, params: {id: @user, user: FactoryBot.attributes_for(:user)}
        expect(flash).not_to be present?
        expect(edit_user_path).to redirect_to root_url
      end

      it 'redirect update when logged in as a wrong user' do
        log_in_as(@other_user)
        process :update, method: :patch, params: {id: @user, user: FactoryBot.attributes_for(:user)}
        expect(flash).not_to be present?
        expect(user_path).to redirect_to root_url
      end
    end
    # log in as a particular user
    def log_in_as(user)
      session[:user_id] = user.id
    end
  end
end
