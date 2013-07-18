class Api::TimelineController < ApplicationController
  before_filter :authenticate_user!
  def show
    begin
      @weekly_total = Payment.where("created_at > ?", Time.now - 1.week).collect{ |p| p.amount }.sum
      current_vouchers = Voucher.where("start_date <= ? and end_date >= ?", Time.now, Time.now)
      @total_vouchers = current_vouchers.collect{ |v| v.total }.sum
      @available_vouchers = current_vouchers.collect{ |v| v.available }.sum
      @payments = Payment.order("created_at DESC").limit(3)
    
      hash = {
        :weekly_total => @weekly_total,
        :total_vouchers => @total_vouchers,
        :available_vouchers => @available_vouchers,
        :payments => @payments.map { |p| 
          {
            :id => p.id,
            :user_id => p.user_id,
            :amount => p.amount,
            :offer => [Offer.find(p.offer_id)].map { |o|
              {
                :id => o.id,
                :name => o.name,
                :details => o.details,
                :available => o.available,
                :total => o.total,
                :price => o.price,
                :venue => [Venue.find(o.venue_id)].map { |v|
                  {
                    :id => v.id,
                    :name => v.name,
                    :description => v.description                  
                  }
                }
              }
            }
          }
        }
      }
    
      render :json => {:error => false, :content => hash}
    rescue Exception => e
      render :json => {:error => true, :description => "Internal Server Error."}, status: 503 and return
    end
  end

  def use_voucher
    render :json => {:error => true, :description => "There's currently no way to use this, so please tell me how should I implement it."}, status: 503 and return
  end

  def verify_payment_and_show_voucher
    # TO BE IMPLEMENTED BY THE MOBILE APP DEVELOPER
    render :json => {:error => true, :description => "To be implemented by the mobile app developer."}, status: 503 and return
  end
end
