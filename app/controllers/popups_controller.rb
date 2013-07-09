class PopupsController < ApplicationController
  layout "popup"

  def deal_popup_not_logged
    begin
      @offer = Offer.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      @offer = Venue.find(params[:id]).offers.first
    end
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
        Home.sendText(phone, "Download the FoodCircles app! https://itunes.apple.com/us/app/foodcircles/id526107767?mt=8")
      elsif type == 'android'
        Home.sendText(phone, "Download the FoodCircles app! https://play.google.com/store/apps/details?id=co.foodcircles")
      end
    end
  end
end
