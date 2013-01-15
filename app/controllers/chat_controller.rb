class ChatController < ApplicationController
  def index
  end

  def venues
    @venues = Venue.active.currently_available
  end

  def show
    @v = Venue.find params[:id]
  end
end
