class PaymentController < ApplicationController
  include Mandrill::Rails::WebHookProcessor
  
  def index
  end

  def stripe
    @payment = Payment.new
  end
  
  def handle_inbound(event_payload)
    if message = event_payload.msg.presence
      from_email = msg.from_email
      mail_subject = msg.subject
      mail_text = msg.text
      
      inbound_mark_used(from_email, mail_subject, mail_text)
    end
    render :nothing => true
  end
  
  def inbound_mark_used(from_email, mail_subject, mail_text)
    from = from_email
    subject = mail_subject
    text = mail_text
    
    if (subject == "used")
      payment = Payment.find_by_code(text)      
      payment.state = "Used"
      payment.save
    else
      #This needs to be updated to lookup payment by from e-mail
      payment = Payment.find_by_code(text)
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
