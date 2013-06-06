class PopupsController < ApplicationController
  layout "popup"

  def deal_popup_not_logged
    @offer = Offer.find(params[:id])
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
