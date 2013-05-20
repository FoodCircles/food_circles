class AddPricesToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :price, :float
    add_column :offers, :original_price, :float
  end
end
