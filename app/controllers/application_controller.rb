class ApplicationController < ActionController::Base
  protect_from_forgery
  def authorize
    if current_user.nil?
      redirect_to login_path, :alert => "You must be logged in to perform that action."
    end
  end

  private
  helper_method :current_user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end


