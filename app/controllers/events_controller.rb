class EventsController < ApplicationController
  before_action :check_login, only: %i[new create attend show]
  before_action :set_events, only: [:index]
  before_action :set_event, only: %i[show attend invite]
  before_action :authorize_owner, only: [:invite]

  def index
    @event = Event.new
  end

  def show; end

  def create
    @event = current_user.events.build(events_params)
    if @event.save
      @event.attendees << current_user
      @event.invited_users << current_user
      redirect_to @event, notice: 'Event created successfully'
    else
      set_events
      render 'index'
    end
  end

  def attend
    if @event.attendees.exists?(current_user.id)
      flash[:error] = 'You already signed up for this event.'
      redirect_to @event
    elsif !@event.invited_users.exists?(current_user.id)
      flash[:error] = 'You are not invited to this event.'
      redirect_to @event
    else
      @event.attendees << current_user
      redirect_to @event, notice: 'Attend succesfully commited'
    end
  end

  def invite
    user = User.find_by(invite_params)
    if user
      if @event.invited_users.exists?(user.id)
        flash[:error] = 'User is already invited.'
        redirect_to @event
      else
        @event.invited_users << user
        redirect_to @event, notice: 'User invited succesful.'
      end
    else
      flash[:error] = 'User not found.'
      redirect_to @event
    end
  end

  private

  def set_events
    @events = Event.includes(:attendees).all
    @prev_events = Event.past
    @upcoming_events = Event.upcoming
  end

  def set_event
    @event = Event.find params[:id]
  end

  def events_params
    params.require(:event).permit(:location, :date, :description, :name)
  end

  def invite_params
    params.require(:user).permit(:name)
  end

  def authorize_owner
    return true if current_user.id == @event.creator_id

    flash[:error] = 'I thought we were friends 😢'
    redirect_to event_path(@event)
  end
end
