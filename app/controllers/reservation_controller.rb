class ReservationController < ApplicationController
  def used_email
    from = params["from_email"]
    subject = params["subject"]
    text = params["text"]
    
    reservation = Reservation.find_by_coupon(text)
    return if !reservation
    
    if (subject == "used")
      used(text)
    end
  end
  
  def active(coupon)
    reservation = Reservation.find_by_coupon(coupon)
    reservation.state = "Active";
    reservation.save;
  end
  
  def expired(coupon)
    reservation = Reservation.find_by_coupon(coupon)
    reservation.state = "Expired";
    reservation.save;
  end
  
  def used(coupon)
    reservation = Reservation.find_by_coupon(coupon)
    reservation.state = "Used";
    reservation.save;
  end
  
end
