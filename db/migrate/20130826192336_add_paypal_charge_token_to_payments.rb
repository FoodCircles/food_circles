class AddPaypalChargeTokenToPayments < ActiveRecord::Migration
  def change
    add_column :venues, :paypal_charge_token, :string
  end
end
