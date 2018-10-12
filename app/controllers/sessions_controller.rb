class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_path
      flash[:primary] = "You are now logged in."
    else
      flash.now[:danger] = 'We do not recognize your sign-in information. Please try again.'
    render 'new'
  end

  def destroy
  end
end
end
