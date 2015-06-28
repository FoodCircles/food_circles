class Api::VenuesController < ApplicationController
  def show
    render :json => {:error => false,
      :content => Venue.all.as_json(lat: params[:lat], lon: params[:lon], all: true),
      :total_people_aided => total_meals,
      :people_aided => weekly_progress[:current_progress],
      :weekly_goal => weekly_progress[:adjusted_total]}
  end

  def homeless
    venue = Venue.where(device_id: params[:device_id]).first.as_json
    calculations = Calculations::All.new(venue)
    balance = calculations.total_purchases_by_charities[1].round
    render :json => {
      :error => false,
      :content =>  venue,
      :total_people_aided => total_meals,
      :people_aided => weekly_progress[:current_progress],
      :weekly_goal => weekly_progress[:adjusted_total],
      :balance => balance
    }
  end
end
