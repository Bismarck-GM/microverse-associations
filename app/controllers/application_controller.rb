class ApplicationController < ActionController::Base

  protected

  def current_user
    User.find(session[:current_user_id])
  end

  def check_login
    redirect_to new_session_path, notice: "Must be logged in" if session[:current_user_id].nil? 
  end
end
