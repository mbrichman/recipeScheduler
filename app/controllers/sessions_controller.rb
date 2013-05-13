class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if !params[:email].present? || !params[:password].present?
      redirect_to new_session_path, notice: "Email and Password cannot be blank"
      return
    end
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      redirect_to new_session_url, notice: "Email or password is invalid."
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: "Logged Out!"
  end
end
