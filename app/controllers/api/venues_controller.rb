class Api::VenuesController < ApplicationController
  def show
<<<<<<< HEAD
    venues = Venue.visible.within_radius_of_location(params[:lat], params[:lon])
    venues = venues.empty? ? Venue.visible.scoped : venues
=======
>>>>>>> parent of 6ccaf67... Merge pull request #26 from bcassedy/location_fixes
    render :json => {:error => false,
      :content => Venue.all.as_json(lat: params[:lat], lon: params[:lon], all: true),
      :total_people_aided => total_meals,
      :people_aided => weekly_progress[:current_progress],
      :weekly_goal => weekly_progress[:adjusted_total]}
  end

  def homeless
    venue = Venue.where(device_id: params[:device_id]).first
    calculations = Calculations::All.new(venue)
    balance = calculations.total_purchases_by_charities[1].round
    homeless = venue.as_json
    homeless[:balance] = balance
    render :json => {
      :error => false,
      :content =>  homeless,
      :total_people_aided => total_meals,
      :people_aided => weekly_progress[:current_progress],
      :weekly_goal => weekly_progress[:adjusted_total]
    }
  end
end
