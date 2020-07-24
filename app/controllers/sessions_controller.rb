class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(user_params)
    
    unless @user.nil?
      session[:current_user_id] = @user.id

    else
      redirect_to new_session_path 
    end

  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
