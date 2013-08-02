class Api::VenuesController < ApplicationController
  def show
    @venue = Venue.where(:latlon => Venue.rgeo_factory_for_column(:latlon).point(params[:lat], params[:lon]))
    render :json => {:error => false, :content => @venue.as_json }
  end
end
