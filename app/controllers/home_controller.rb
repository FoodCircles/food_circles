class HomeController < ApplicationController
  def index
    #UserMailer.signupsuccess
    #render :text=>'here2' and return
    @offers = Offer.limit(9)

    get_progress
    
    @cities = {}
    Venue.all.collect do |venue|
      if @cities[venue.city].nil?
        @cities[venue.city] = 1
      else
        @cities[venue.city] += 1
      end
    end

    if params[:phone]
      app_popup(params[:phone], params[:type])
    end
  end

  def cater
  end

  def thanks
  end

  def app_popup(phone, type)
    if type == 'iphone'
      sendText(phone, "Download the FoodCircles app! https://itunes.apple.com/us/app/foodcircles/id526107767?mt=8")
    elsif type == 'android'
      sendText(phone, "Download the FoodCircles app! https://play.google.com/store/apps/details?id=co.foodcircles")
    end
  end
end
