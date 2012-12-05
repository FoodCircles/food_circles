class CreateCharities < ActiveRecord::Migration
  def change
    create_table :charities do |t|
      t.string :name
      t.string :web
      t.integer :region_id
      t.string :address
      t.string :city
      t.integer :state_id
      t.string :zip
      t.text :description

      t.timestamps
    end
  end
end
