class PopupsController < ApplicationController
  layout "popup"

  def deal_popup_not_logged
    @offer = Offer.find(params[:id])
  end

  def reciept
    @payment = Payment.find(params[:id])
  end
end
