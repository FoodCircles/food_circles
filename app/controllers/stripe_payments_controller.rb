class StripePaymentsController < ApplicationController
  #Stripe Payments Controller for Test Envi.
  def new
  end

  def create
    # Amount in cents
    @amount = params[:amount].to_f

    #tkxel_dev: create Customers and save them on stripe DB.
    customer = Stripe::Customer.create(
        :email => 'example@stripe.com',
        :card  => params[:stripe_token]
    )
    #tkxel_dev: Charges to be deducted handle here , Credit card info. validation also complete in this phase.
    charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => (@amount * 100).to_i,
        :description => 'Rails Stripe customer',
        :currency    => 'usd'
    )

    Payment.create(
                   user: current_user,
                   amount: @amount,
                   stripe_charge_token: charge.id,
                   offer_id: params[:offer_id]
                   )

    offer = Offer.find(params[:offer_id])
    offer.venue.vouchers_available -= 1
    #tkxel_dev: Error messages in case of incorrect Credentilas

    redirect_to :controller => 'timeline', :action => 'index'
  rescue Stripe::CardError => e
    flash[:error] = e.message
    render :action => 'new'
  end

end
