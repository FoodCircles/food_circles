class ReceiveTextController < ApplicationController
  def index
    body = params["Body"]
    number = params["From"]

    body.gsub!(/[^0-9]/,"")
    number.gsub!(/[^0-9]/,"")
    
    user = User.find_by_phone(number)
    return if !user
    
    if (1..20).include? body
      r = user.reservations.last
      makeCall(r.venue, r)
    end
  end
  
  def used
    body = params[:Body]
    from = params[:From]
    
    if body.blank?
      body.gsub!(/[^0-9]/,"")
    end
    
    if from.blank?
      number.gsub!(/[^0-9]/,"")
    end
    
    if body.blank?
      body.upcase!
      payment = Payment.find_by_code(body)      
      payment.state = "Used"
      payment.save
    end
    
    response = "Voucher #{body} confirmed as used. Thanks for your purchase and for feeding children in need through your dining."
    
    sendText(from, response)
    
    render :nothing => true
  end
end
