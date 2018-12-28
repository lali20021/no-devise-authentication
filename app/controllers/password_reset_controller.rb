class PasswordResetController < ApplicationController


  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email])
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:primary] = "You will recieve an email with password reset instructions shortly"
      redirect_to root_path
    else
      flash.now[:alert] = "Email address is not found"
      render 'new'
    end
  end

  def edit
    get_user
    valid_user
    check_expiration
  end

  def update
    get_user
    valid_user
    check_expiration

    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be blank")
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = 'Your password was reset successfully.'
      redirect_to @user
    else
      render 'edit'
    end

  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    unless @user && @user.activated? && @user.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:alert] = 'Your password has expired'
      redirect_to new_password_reset_url
    end
  end
end
