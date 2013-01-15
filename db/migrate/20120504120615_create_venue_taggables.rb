class CreateVenueTaggables < ActiveRecord::Migration
  def change
    create_table :venue_taggables do |t|
      t.integer :venue_tag_id
      t.integer :venue_id

      t.timestamps
    end
  end
end
