class CreatePostcards < ActiveRecord::Migration
  def change
    create_table :postcards do |t|
      t.string :city, :null => false
      t.string :state, :null => false
      t.string :user_name, :null => false
      t.string :restaurant_name, :null => false
      t.text :message, :null => false
      t.boolean :sent, :default => false

      t.timestamps
    end
  end
end
