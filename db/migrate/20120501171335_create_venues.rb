class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.integer :user_id
      t.text :description
      t.string :address
      t.string :city
      t.integer :state_id
      t.string :zip
      t.string :neighborhood
      t.string :web
      t.integer :timezone_id
      t.integer :price
      t.point :latlon, :geographic => true, :srid => 4326

      t.timestamps
    end
  end
end
