class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :user
      t.float :amount
      t.string :stripe_charge_token

      t.timestamps
    end
    add_index :payments, :user_id
  end
end
