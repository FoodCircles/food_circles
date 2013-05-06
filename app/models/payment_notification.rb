class PaymentNotification < ActiveRecord::Base
  attr_accessible :parameters, :paypal_id, :status, :transaction_id, :address_city, :address_country, :address_name, :address_state, :address_street, :address_zip, :first_name, :invoice, :last_name, :mc_currency, :mc_gross, :payer_email, :payer_status, :payment_date, :payment_type, :txn_id, :verify_sign, :user_id
end
