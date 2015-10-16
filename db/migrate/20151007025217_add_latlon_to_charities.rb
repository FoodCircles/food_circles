class AddLatlonToCharities < ActiveRecord::Migration
  def change
    add_column :charities, :latlon, :point, geographic: true, srid: 4326
  end
end
