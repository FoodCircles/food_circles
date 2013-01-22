class AddMultiplierToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :multiplier, :decimal, :default => 1.50

  end
end
