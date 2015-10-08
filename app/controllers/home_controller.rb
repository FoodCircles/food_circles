class HomeController < ApplicationController
  def index
    if request.subdomain and not ['', 'www','staging', 'testing'].include?(request.subdomain)
      @sub_charity = Charity.active.find_by_subdomain(request.subdomain)
      flash.now[:notice] = "100% of your purchase will be directed to #{@sub_charity.name}."
    end

    enqueue_mix_panel_event "Visits Home Page"

    @venues = Venue.visible.with_display_offers.page(params[:page]).per_page(9)
    @cities = {}
    @news = News.website

    @watched_venues = if current_user
      current_user.watched_venues
    else
      []
    end

    if id = params[:id]
      venue = Venue.where(slug: id).first || Venue.joins(:offers).where(offers: {id: id}).first
      if venue && venue.sold_out?
        custom_body_classes << "sold-out"
        flash.now[:notice] = "#{venue.name} is sold out this week. Get first dibs when they're back by subscribing below."
      end
      set_meta_tags  :og => { :image => venue.main_image.thumb("670x313").url  } if venue
    else
      set_meta_tags  :og => { :image => "http://1-ps.googleusercontent.com/h/www.joinfoodcircles.org/media/xBAhbB1sHOgZmSSIqMjAxMy8wOC8xOS8xNF8zMV8wNl82NzBfcF9jbF9tYWluLnBuZwY6BkVUWwg6BnA6CnRodW1iSSIMNjcweDMxMwY7BlQ.pagespeed.ic.1af83aWD8u.jpg" }
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
      sendText(phone, "Download the FoodCircles app! https://itunes.apple.com/us/app/foodcircles-for-iphone/id710592600?ls=1&mt=8e")
    elsif type == 'android'
      sendText(phone, "Download the FoodCircles app! https://play.google.com/store/apps/details?id=co.foodcircles")
    end
  end
end
