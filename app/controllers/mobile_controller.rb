class MobileController < ApplicationController
  def login
    @user = User.find_by_email(params[:email].downcase)
    if !@user
      @user = User.create!({:email => params[:email], :password => params[:password], :name => params[:email]})
    end
    
    o = Offer.find(params[:offer])
    @r = @user.reservations.create
    @r.offer_id = params[:offer]
    @r.venue_id = o.venue.id
    @r.charity_id = params[:charity]
    @r.name = @user.name
    @r.num_diners = o.min_diners
    @r.coupon = genCoupon
    @r.save

    UserMailer.delay.voucher(@user, @r)
    
    render :json => @r, :callback => params[:callback]
  end
  
  def signup
    o = Offer.find(params[:offer])
    @user = User.find_by_email(params[:email])
    if @user
        render :json => {:success => false, :errors => 'Your account already exists. Please sign in instead.', :status => 500}, :callback => params[:callback]
        return
    end
    begin
      @user = User.create!({:email => params[:email], :password => params[:password], :name => params[:name]})
    rescue
        render :json => {:success => false, :errors => 'There was an error creating your account', :status => 500}, :callback => params[:callback]
        return
    end
    @r = @user.reservations.create
    @r.offer_id = params[:offer]
    @r.venue_id = o.venue.id
    @r.charity_id = params[:charity]
    @r.name = @user.name
    @r.num_diners = o.min_diners
    @r.coupon = genCoupon
    @r.save

    UserMailer.delay.voucher(@user, @r)
    UserMailer.signupsuccess(@user).deliver

    render :json => @r, :callback => params[:callback]
  end

  def notification
    render :json => Notification.offset(rand(Notification.count)).first, :callback => params[:callback]
  end

  def callahead
    @r = Reservation.find_by_coupon(params[:coupon])
    @minutes = params[:in_minutes]
    makeCall(@r.venue, @r, @minutes)
    render :nothing => true
  end

  def num_users
    count = User.count

    render :json => { count: count }
  end
end
