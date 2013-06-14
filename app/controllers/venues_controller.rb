class VenuesController < ApplicationController

  def index

    params[:lat] = nil if ['null'].include? params[:lat]

    if params[:offline]
      begin
        @venues = (lat(params[:lat]) ? Venue.active.not_available_with_location(params[:lat],params[:lon]) : Venue.active.not_available)
        if !@venues || !@venues.any?
          @venues = Venue.active.not_available
        end
      rescue
        @venues = Venue.active.not_available
      end
    else
      begin
        @venues = (lat(params[:lat]) ? Venue.active.currently_available_with_location(params[:lat],params[:lon]) : Venue.active.currently_available)
        if !@venues || !@venues.any?
          @venues = Venue.active.currently_available
        end
      rescue
        @venues = Venue.active.currently_available
      end
    end

    

    if ['json','jsonp'].include?(params[:format])
      if (params[:offline])
        render :json => (lat(params[:lat]) ? @venues.as_json(:lat => params[:lat], :lon => params[:lon], :not_available => true) : @venues), :callback => params[:callback]
      else
        render :json => (lat(params[:lat]) ? @venues.as_json(:lat => params[:lat], :lon => params[:lon]) : @venues), :callback => params[:callback]
      end
    end
  end

  def show
    # @v = Venue.find(params[:id])
    @offer = Venue.find(params[:id]).offers.first
    
    if ['json','jsonp'].include?(params[:format])
        render :json => @v, :callback => params[:callback]
    end
  end

  private

  def lat(l)
    l && l != 'undefined'
  end

end
