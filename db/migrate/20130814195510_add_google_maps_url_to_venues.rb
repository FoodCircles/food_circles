class AddGoogleMapsUrlToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :google_maps_url, :string
  end
end
