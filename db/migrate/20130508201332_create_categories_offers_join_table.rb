class CreateCategoriesOffersJoinTable < ActiveRecord::Migration
  def up
  end

  def down
  end

  def change
    create_table :categories_offers, :id => false do |t|
      t.integer :category_id
      t.integer :offer_id
    end
  end
end
