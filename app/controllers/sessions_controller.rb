class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(user_params)

    if @user.nil?
      flash[:error] = 'User not found.'
      redirect_to new_session_path
    else
      session[:current_user_id] = @user.id
      redirect_to events_path
    end
  end

  def destroy
    reset_session
    redirect_to new_session_path
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
