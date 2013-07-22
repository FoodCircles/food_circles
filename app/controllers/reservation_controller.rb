class ReservationController < ApplicationController
  def used
    from = params["from_email"]
    subject = params["subject"]
    text = params["text"]
    
    reservation = Reservation.find_by_coupon(text)
    return if !reservation
    
    if (subject == "used")
      mark_used(text)
    end
  end
  
  def mark_used(coupon)
    reservation = Reservation.find_by_coupon(coupon)
    reservation.state = "Used";
    reservation.save;
  end
  
end
