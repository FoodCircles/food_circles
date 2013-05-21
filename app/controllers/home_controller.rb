class HomeController < ApplicationController
  def index
    #UserMailer.signupsuccess
    #render :text=>'here2' and return
    @offers = Offer.limit(9)
    
    @progress = 0
    Stripe::Charge.all.each do |charge|
      if Time.at(charge.created) > Time.now - 1.week
        @progress += charge.amount
      end
    end
    @progress /= 100

    @total_vouchers = 0
    Offer.all.each do |offer|
      @total_vouchers += offer.price * offer.total
    end
    @total_vouchers = @total_vouchers.round
    @adjusted_total = 3 * @total_vouchers / 4
  end

  def cater
  end


  def thanks
  end
end
