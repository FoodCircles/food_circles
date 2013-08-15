class SettingsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @card_last_4_digits = if current_user.stripe_customer_token && customer = stripe_customer
      customer.active_card.last4
    end
  end

  # DELETE /settings/credit_card
  def credit_card
    customer = stripe_customer
    current_user.stripe_customer_token = nil
    current_user.save!
    customer.delete
    render :json => {:success => true, :description => "The Credit Card was deleted"}
  end

  private
  def stripe_customer
    Stripe::Customer.retrieve current_user.stripe_customer_token
  rescue Stripe::InvalidRequestError
    nil
  end
end
