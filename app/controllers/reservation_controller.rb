class ReservationController < ApplicationController
  
  def active
    reservation = Reservation.find_by_coupon(params[:coupon])
    reservation.state = "Active";
    reservation.save;
    
    render :nothing => true
  end
  
  def expired
    reservation = Reservation.find_by_coupon(params[:coupon])
    reservation.state = "Expired";
    reservation.save;
    
    render :nothing => true
  end
  
  def used
    reservation = Reservation.find_by_coupon(params[:coupon])
    reservation.state = "Used";
    reservation.save;
    
    render :nothing => true
  end
  
end
