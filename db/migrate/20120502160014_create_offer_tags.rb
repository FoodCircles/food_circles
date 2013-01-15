class CreateOfferTags < ActiveRecord::Migration
  def change
    create_table :offer_tags do |t|
      t.string :name

      t.timestamps
    end
  end
end
