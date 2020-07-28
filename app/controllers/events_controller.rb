class EventsController < ApplicationController
  before_action :check_login, only: [:new]
  
  def index
    @events = Event.includes(:attendees).all
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @events = current_user.events.create(events_params)
    redirect_to events_path, notice: "Event created succesfully"
  end

  def attend
    @event = Event.find(params[:id])
    if @event.attendees.exists?(current_user.id)
      redirect_to events_path, notice: "You already signed up for this event."
    else
      @event.attendees << current_user
      redirect_to events_path, notice: "Attend succesfully commited"
    end
  end

  private

  def events_params
    params.require(:event).permit(:location, :date, :description)
  end
end
