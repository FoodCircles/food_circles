class PaymentNotificationsController < ApplicationController
  def create
    @payment_notification = PaymentNotification.new(params[:payment_notification])

    #PaymentNotification.create!()

    PaymentNotification.create!(:user_id => params[:custom], :address_city => params[:address_city], :address_country => params[:address_country], :address_name => params[:address_name], :address_state => params[:address_state], :address_street => params[:address_street], :address_zip => params[:address_zip], :first_name => params[:first_name], :invoice => params[:invoice], :last_name => params[:last_name], :status => params[:payment_status], :mc_currency => [:mc_currency], :mc_gross => params[:mc_gross], :payer_email => params[:payer_email], :payer_status => params[:payer_status], :payment_date => params[:payment_date], :payment_type => params[:payment_type], :txn_id => params[:txn_id], :verify_sign => params[:verify_sign])

    render :nothing => true

  end

end
