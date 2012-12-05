class FixTimeZoneForVenues < ActiveRecord::Migration
  def up
    remove_column :venues, :timezone_id
    add_column :venues, :time_zone_id, :integer
  end

  def down
    add_column :venues, :timezone_id, :integer
    remove_column :venues, :time_zone_id
  end
end
