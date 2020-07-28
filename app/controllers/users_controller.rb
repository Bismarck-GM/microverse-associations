class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(user_params)
    session[:current_user_id] = @user.id
    redirect_to events_path
  end
  
  def show
    @user = User.find(params[:id])
    @prev_events = Event.past
    @upcoming_events = Event.upcoming
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
