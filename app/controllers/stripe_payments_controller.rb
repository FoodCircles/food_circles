class StripePaymentsController < ApplicationController

  #Stripe Payments Controller for Test Envi.
  def new
  end

  def create
    # Amount in cents
    @amount = params[:amount].to_f
    offer = Offer.find(params[:offer_id])

    if !user_signed_in?
      @user = User.find_by_email(params[:user_email])
      if @user.nil?
        @user = User.new(:email => params[:user_email], :password => params[:user_password], :password_confirmation => params[:user_password])
        @user.save
      else
        if !@user.valid_password?(params[:user_password])

          flash[:error] = "Wrong password!"
          render :action => 'new' and return
        end
      end
      sign_in(@user)
      
    end

    if !current_user.stripe_customer_token.nil?
      customer = Stripe::Customer.retrieve(current_user.stripe_customer_token)
    else
      #tkxel_dev: create Customers and save them on stripe DB.
      customer = Stripe::Customer.create(
          :email => current_user.email,
          :card  => params[:stripe_token]
      )
      current_user.stripe_customer_token = customer.id
      current_user.save
    end

    #tkxel_dev: Charges to be deducted handle here , Credit card info. validation also complete in this phase.
    charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => (@amount * 100).to_i,
        :description => offer.venue.name + ' - ' + offer.name,
        :currency    => 'usd'
    )

    payment = Payment.create(
        user: current_user,
        amount: @amount,
        stripe_charge_token: charge.id,
        offer: offer
    )

    offer.venue.vouchers_available -= 1
    offer.venue.save
    #tkxel_dev: Error messages in case of incorrect Credentilas

    UserMailer.setup_email(current_user, payment)
    
    unless current_user.phone.nil?
      send_text_message(current_user, payment)
    end
    
    current_user.payments << payment

    redirect_to :controller => 'timeline', :action => 'index', :reciept_id => payment.id
  rescue Stripe::CardError => e
    flash[:error] = e.message
    render :action => 'new'
  end
  
  private
  def send_text_message(user, payment)
 
    twilio_sid = "AC085df9dc6444a3588933ae0ddd9d95e7"
    twilio_token = "95cc7f360064ab606017dad6d2eb38a5"
    twilio_phone_number = "4422223663"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => user.phone,
      :body => "FoodCircles offer\nCode: #{payment.code}\nItem:#{payment.offer.name}\nAmount donated: $#{payment.amount}\nVenue: #{payment.offer.venue.name}"
    )
  end

end
