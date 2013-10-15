class HomeController < ApplicationController
  def index
    enqueue_mix_panel_event "Visits Home Page"

    @venues = Venue.with_display_offers.page(params[:page]).per_page(9)
    @cities = {}
    @news = News.website

    @watched_venues = if current_user
      current_user.watched_venues
    else
      []
    end

    if id = params[:id]
      venue = Venue.where(slug: id).first || Venue.joins(:offers).where(offers: {id: id}).first
      custom_body_classes << "sold-out" if venue.sold_out?
      flash[:notice] = "#{venue.name} is sold out this week. Get first dibs when they're back by subscribing below."
    end

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
