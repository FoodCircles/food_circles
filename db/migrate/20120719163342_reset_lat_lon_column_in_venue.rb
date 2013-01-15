class ResetLatLonColumnInVenue < ActiveRecord::Migration
  def up
    remove_column :venues, :latlon
    add_column :venues, :latlon, :point, :geographic => true, :srid => 4326
  end

  def down
  end
end
