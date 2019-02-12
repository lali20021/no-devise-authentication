class ApplicationController < ActionController::Base
  before_action :clear_my_cashe
  protect_from_forgery with: :exception
  include SessionsHelper

private
def clear_my_cashe
  response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate'
  response.headers['Cache-Control'] = 'no-cache'
  response.headers['Cache-Control'] = '0'
end

def check_session
  redirect_to root_path unless current_user
end
end
