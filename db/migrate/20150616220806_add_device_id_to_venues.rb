class AddDeviceIdToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :device_id, :string
  end
end
