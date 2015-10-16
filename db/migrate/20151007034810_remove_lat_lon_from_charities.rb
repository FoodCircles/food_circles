class RemoveLatLonFromCharities < ActiveRecord::Migration
  def up
    remove_column :charities, :lat
    remove_column :charities, :lon
  end

  def down
    add_column :charities, :lat, :float
    add_column :charities, :lon, :float
  end
end
