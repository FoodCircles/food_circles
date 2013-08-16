class SettingsController < ApplicationController
  include PaymentCommons

  before_filter :authenticate_user!

  def show
    get_friends_purchases
    load_payments

    @card_last_4_digits = if current_user.stripe_customer_token && customer = stripe_customer
      customer.active_card.last4
    end
  end

  def update
    if current_user.update_attributes(params[:user])
      render :json => {:success => true, :description => "User Settings were updated"}
    else
      render :json => {:error => true, :description => "There was an error", :errors => current_user.errors.full_messages.to_sentence}
    end
  end

  def update_password
    if current_user.update_with_password(params[:user])
      sign_in current_user, :bypass => true
      render :json => {:success => true, :description => "User Settings were updated"}
    else
      render :json => {:error => true, :description => "There was an error", :errors => current_user.errors.full_messages.to_sentence}
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
