class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        flash[:primary] = 'You are now logged in.'
        redirect_to user
      else
        message = 'Account was not activated.'
        message += 'Check your email to activate your account.'
        flash[:danger] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'We do not recognize your sign-in information. Please try again.'
    render 'new'
  end
end

  def destroy
    log_out if logged_in?
    flash[:primary] = 'You are now logged out.'
    check_session
  end
end
