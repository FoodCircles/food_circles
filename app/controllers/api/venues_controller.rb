class Api::VenuesController < ApplicationController
  def show
    render :json => {:error => false, :content => Venue.all.as_json(lat: params[:lat], lon: params[:lon], all: true) }
  end
end
