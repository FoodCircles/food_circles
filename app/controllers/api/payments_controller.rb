class Api::PaymentsController < ApplicationController
  before_filter :authenticate_user!

  # POST /api/payments
  def create
    create_params = params[:payment].slice(:offer_id, :amount, :paypal_charge_token, :charity_id)
    create_params[:user_id] = current_user.id

    @payment = Payment.new(create_params)
    if @payment.save
      venue = @payment.offer.venue
      venue.vouchers_available -= 1
      venue.save
      UserMailer.setup_email(current_user, @payment)

      render :json => {:error => false, :content => @payment.as_json }
    else
      render :json => {:error => true, :description => "Error saving the payment", :errors => @payment.errors.full_messages}
    end
  end
end
