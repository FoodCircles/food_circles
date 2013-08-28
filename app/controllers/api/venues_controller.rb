class Api::VenuesController < ApplicationController
  def show
    meters_on_a_mille = 1609.344
    fifty_milles_as_meters = 50*meters_on_a_mille
    point = Venue.rgeo_factory_for_column(:latlon).point(params[:lat], params[:lon])
    @venues = Venue.where(["ST_DWithin(latlon, ?, #{fifty_milles_as_meters})", point])
    render :json => {:error => false, :content => @venues.as_json(include_distance_to: point) }
  end
end
