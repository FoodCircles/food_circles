class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :venue_id
      t.integer :offer_id
      t.integer :charity_id
      t.integer :num_diners
      t.string :occasion
      t.boolean :confirmed
      t.datetime :time_confirmed
      t.string :coupon
      t.string :name
      t.string :phone

      t.timestamps
    end
  end
end
