class DropOfferTags < ActiveRecord::Migration
  def up
    drop_table :offer_tags
    drop_table :offer_taggables
  end

  def down
  end
end
