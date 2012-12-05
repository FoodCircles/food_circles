class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :author_name
      t.text :content
      t.integer :rating
      t.integer :venue_id

      t.timestamps
    end
    add_index :reviews, :venue_id
  end
end
