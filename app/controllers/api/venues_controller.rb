class Api::VenuesController < ApplicationController
  def show
    render :json => {:error => false,
      :content => Venue.all.as_json(lat: params[:lat], lon: params[:lon], all: true),
      :people_aided => weekly_progress[:current_progress],
      :weekly_goal => weekly_progress[:adjusted_total]}
  end
end
