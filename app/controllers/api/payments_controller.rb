class Api::PaymentsController < ApplicationController
  before_filter :authenticate_user!

  # POST /api/payments
  def create
    create_params = params[:payment].slice(:offer_id, :amount)
    create_params[:user_id] = current_user.id

    @payment = Payment.new(create_params)
    if @payment.save
      render :json => {:error => false, :content => @payment.as_json }
    else
      render :json => {:error => true, :description => "Error saving the payment", :errors => @payment.errors.full_messages}
    end
  end
end
