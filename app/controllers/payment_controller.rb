class PaymentController < ApplicationController
  def index
  end

  def stripe
    @payment = Payment.new
  end
  
  def active
    payment = Payment.find_by_coupon(params[:coupon])
    payment.state = "Active"
    payment.save
    
    render :nothing => true
  end
  
  def expired
    payment = Payment.find_by_coupon(params[:coupon])
    payment.state = "Expired"
    payment.save
    
    render :nothing => true
  end
  
  def used  
    payment = Payment.find_by_coupon(params[:coupon])
    payment.state = "Used"
    payment.save
    
    render :nothing => true
  end
end
