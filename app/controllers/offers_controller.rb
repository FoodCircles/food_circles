class OffersController < ApplicationController
  def show
    @offer = Offer.find(params[:id])
    if ['json','jsonp'].include?(params[:format])
      render :json => @offer, :callback => params[:callback]
    end
  end
end