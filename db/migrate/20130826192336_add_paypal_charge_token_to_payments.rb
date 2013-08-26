class AddPaypalChargeTokenToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :paypal_charge_token, :string
  end
end
