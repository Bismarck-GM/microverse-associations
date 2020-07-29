class EventsController < ApplicationController
  before_action :check_login, only: [:new, :create, :attend]
  
  def index
    @events = Event.includes(:attendees).all
    @event = Event.new
    @prev_events = Event.past
    @upcoming_events = Event.upcoming

  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = current_user.events.create(events_params)
    @event.attendees << current_user
    redirect_to @event, notice: "Event created succesfully"
  end

  def attend
    @event = Event.find(params[:id])
    if @event.attendees.exists?(current_user.id)
      redirect_to @event, notice: "You already signed up for this event."

    elsif !@event.invited_users.exists?(current_user.id)
      redirect_to @event, notice: "You are not invited to this event."

    else
      @event.attendees << current_user
      redirect_to @event, notice: "Attend succesfully commited"
    end
  end

  def invite
    @event = Event.find(params[:id])
    user = User.find_by(invite_params)
    if user
      if @event.invited_users.exists?(user.id)
        redirect_to @event, notice: "User is already invited."
      else
        @event.invited_users << user
        redirect_to @event, notice: "User invited succesful."
      end
    else
      redirect_to @event, notice: "User not found."
    end
  end

  private

  def events_params
    params.require(:event).permit(:location, :date, :description, :name)
  end

  def invite_params
    params.require(:user).permit(:name)
  end
end
