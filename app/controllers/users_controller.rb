class UsersController < ApplicationController
  before_action :check_login, only: %(invites)

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
    @prev_created_events = @user.events.past
    @upcoming_created_events = @user.events.upcoming
    @prev_appointments = @user.appointments.past
    @upcoming_appointments = @user.appointments.upcoming
  end

  def invites
    @attended_events = current_user.appointments.pluck('id')
    @invites = current_user.invites.where('invite_users.id NOT IN (?)', @attended_events)
    render 'invites'
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
