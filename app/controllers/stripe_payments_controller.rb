class StripePaymentsController < ApplicationController
  #Stripe Payments Controller for Test Envi.
  def new
  end

  def create
    # Amount in cents
    @amount = params[:amount].to_f
    offer = Offer.find(params[:offer_id])

    if current_user.stripe_customer_token
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

    redirect_to :controller => 'timeline', :action => 'index', :reciept_id => payment.id
  rescue Stripe::CardError => e
    flash[:error] = e.message
    render :action => 'new'
  end

end
