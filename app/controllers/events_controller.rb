class EventsController < ApplicationController
  before_action :check_login, only: [:new]
  def index
    @events = Event.all
  end

  def new
    @events = Event.new
  end

  def create
    @events = Event.create(events_params)
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

  def show
    
  end
  private

  def events_params
    params.require(:event).permit(:location, :date, :description)
  end
end
