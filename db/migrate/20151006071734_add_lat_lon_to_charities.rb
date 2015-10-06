class AddLatLonToCharities < ActiveRecord::Migration
  def change
    add_column :charities, :lat, :float
    add_column :charities, :lon, :float
  end
end
