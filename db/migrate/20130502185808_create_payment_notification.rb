class CreatePaymentNotification < ActiveRecord::Migration
  def change
    create_table :payment_notifications do |t|
      t.string :status
      t.string :address_city
      t.string :address_name
      t.string :address_state
      t.string :address_street
      t.string :address_zip
      t.string :first_name
      t.string :last_name
      t.string :invoice
      t.string :mc_currency
      t.string :mc_gross
      t.string :payer_email
      t.string :payer_status
      t.string :payment_type
      t.string :verify_sign
      t.integer :txn_id
      t.integer :transaction_id
      t.integer :paypal_id
      t.integer :user_id
      t.text :parameters
      
      t.datetime :payment_date

      t.timestamps
    end
  end
end
