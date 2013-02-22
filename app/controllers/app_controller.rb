class AppController < ApplicationController

  def index
    Reservation.all(:select => "created_at, user_id")
    @vid = params[:v] if params[:v]
    @oid = params[:o] if params[:o]
  end

  def getVenue
    @v = Venue.find(params[:id])
  end

  def getVenues

    @v = Venue.active.currently_available
    @vc = Venue.active.not_available

  end

  def getCharities
    @charities = Charity.all
  end

  def confirm
    @c = Charity.find(params[:charity])
    @o = Offer.find(params[:offer])
    @v = @o.venue
  end

  def submit
    user = User.find_by_email(params[:email].downcase)
    if !user
      render :action => "redirect_new_info"
      return
    else
      o = Offer.find params[:offer]
      @r = user.reservations.create(:occasion => params[:occasion],
                                    :offer_id => params[:offer],
                                    :charity_id => params[:charity],
                                    :name => user.name + " reservation",
                                    :venue_id => o.venue.id,
                                    :num_diners => o.min_diners,
                                    :coupon => genCoupon)
      handle_text(user, @r)
      handle_email(user, @r)
    end
  end

  def newinfo
    @o = Offer.find params[:offer]
    @c = Charity.find params[:charity]
    @v = @o.venue
    @email = params[:email]
  end

  def create_voucher
    user = User.find_by_email(params[:email].downcase)
    if !user
      user = User.create!({:email => params[:email], :password => "I don't care.", :name => params[:name], :phone => params[:phone]})
    end
    o = Offer.find params[:offer]
    @r = user.reservations.create(:occasion => params[:occasion],
                                  :offer_id => params[:offer],
                                  :charity_id => params[:charity],
                                  :name => user.name + "'s reservation",
                                  :venue_id => o.venue.id,
                                  :num_diners => o.min_diners,
                                  :coupon => genCoupon)
    handle_text(user, @r)
    handle_email(user, @r)
  end

  def voucher
    @reservation = Reservation.find params[:reservation_id]
    @v = @reservation.venue
    @v.save
  end

  def show
    @r = current_user.reservations.last
  end

  protected

  def handle_text(user, r)
    begin
      if user.phone
        #code = (user.name ? "#{user.name.titleize} for #{r.offer.min_diners}" : r.coupon)
        code = r.coupon
        sendText(user.phone,"Thank you for using Foodcircles! Your code is \"#{code}\" for #{r.offer.name} at #{r.venue.name}.")
      end
    rescue
      #we tried
    end
  end

  def handle_email(user, r)
    #UserMailer.delay.voucher(current_user, r)
    UserMailer.create_voucher(user, r)
  end

end
