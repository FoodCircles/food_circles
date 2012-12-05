class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer :venue_id
      t.string :name
      t.text :details
      t.integer :min_diners

      t.timestamps
    end
  end
end
