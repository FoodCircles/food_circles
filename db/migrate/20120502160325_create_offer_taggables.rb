class CreateOfferTaggables < ActiveRecord::Migration
  def change
    create_table :offer_taggables do |t|
      t.integer :offer_tag_id
      t.integer :offer_id

      t.timestamps
    end
  end
end
