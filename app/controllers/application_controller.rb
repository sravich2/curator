class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_client(user_id)
    Feedlr::Client.new(:oauth_access_token => User.find(id = user_id).oauth_token)
  end
end
