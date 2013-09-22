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
    
    # body.gsub!(/[^0-9]/,"")
    # number.gsub!(/[^0-9]/,"")
    
    sendText(from, body)
  end
end
