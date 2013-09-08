class PaymentController < ApplicationController
  def index
  end

  def stripe
    @payment = Payment.new
  end
  
  def inbound_mark_used
    from = params[:from_email]
    subject = params[:subject]
    text = params[:text]
    
    if (params[:subject] == "used")
      payment = Payment.find_by_code(params[:text])      
      payment.state = "Used"
      payment.save
    else 
      payment = Payment.find_by_coupon(params[:from_email])
      payment.state = "Used"
      payment.save
    end
      
    render :nothing => true
  end
  
  def active
    if params[:coupon].blank?
      payment = Payment.find_by_code(params[:code])      
      payment.state = "Active"
      payment.save
    else 
      payment = Payment.find_by_coupon(params[:coupon])
      payment.state = "Active"
      payment.save
    end
      
    render :nothing => true
  end
  
  def expired
    if params[:coupon].blank?
      payment = Payment.find_by_code(params[:code])      
      payment.state = "Expired"
      payment.save
    else 
      payment = Payment.find_by_coupon(params[:coupon])
      payment.state = "Expired"
      payment.save
    end
      
    render :nothing => true
  end
  
  def used  
    if params[:coupon].blank?
      payment = Payment.find_by_code(params[:code])      
      payment.state = "Used"
      payment.save
    else 
      payment = Payment.find_by_coupon(params[:coupon])
      payment.state = "Used"
      payment.save
    end
      
    render :nothing => true
  end
end
