class PopupsController < ApplicationController
  layout "popup"

  def deal_popup_not_logged
    begin
      @offer = Offer.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      @offer = Venue.find(params[:id]).offers.first
    end

    if request.subdomain and not ['', 'www'].include?(request.subdomain)
      sub_charity = Charity.active.find_by_subdomain(request.subdomain)
      @usefunds = sub_charity.use_funds
    end

    @min_offer = @offer.venue.offers.order("min_diners ASC").first
  end

  def reciept
    @payment = Payment.find(params[:id])
    @twitter_status = Rack::Utils.escape("Fed #{@payment.amount.to_i} #{@payment.amount.to_i > 1 ? "children" : "child"} in need simply by eating out. Picked out #{@payment.offer.venue.name} via @foodcircles. #bofo http://joinfoodcircles.org/#{@payment.offer.venue.slug}")
    @facebook_status = {
      :url => "http://joinfoodcircles.org/#{@payment.offer.venue.slug}",
      :image => "http://www.foodcircles.net/assets/home/main_intro_high.png",
      :title => Rack::Utils.escape("Bought one, fed #{@payment.amount.to_i}"),
      :summary => Rack::Utils.escape("Fed #{@payment.amount.to_i} #{@payment.amount.to_i > 1 ? "children" : "child"} simply by eating out. Picked out #{@payment.offer.venue.name} via FoodCircles.")
    }
    @email = {
      :subject => "Bought one, fed #{@payment.amount.to_i}",
      :body => "Hey, just bought a voucher for #{@payment.offer.venue.name}. Proceeds from our meal are going to feed #{@payment.amount.to_i} #{@payment.amount.to_i > 1 ? "children" : "child"} in need. Where/when do you want to meet?"
    }
  end

  def app_popup()
    if params[:phone]
      if type == 'iphone'
        Home.sendText(phone, "Here's the link, friend: https://itunes.apple.com/us/app/foodcircles/id526107767?mt=8")
      elsif type == 'android'
        Home.sendText(phone, "Here's the link, friend: https://play.google.com/store/apps/details?id=co.foodcircles")
      end
    end
  end
end
