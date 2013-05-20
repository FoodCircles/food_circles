class AddOfferToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :offer_id, :integer

  end
end
