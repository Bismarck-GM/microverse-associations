class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:current_user_id] = @user.id
      redirect_to events_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @prev_events = @user.appointments.past
    @upcoming_events = @user.appointments.upcoming
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
