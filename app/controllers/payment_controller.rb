class PaymentController < ApplicationController
  
  def index
  end

  def stripe
    @payment = Payment.new
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
    
    if params[:source] == "email"
      respond_to do |format|
          format.html { render :text => 'Voucher confirmed as used.  Thanks for your purchase and for feeding children in need through your dining.' }
      end
    else
      render :nothing => true  
    end  
  end
end
