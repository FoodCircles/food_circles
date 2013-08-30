class AddTimesToVenueAndOffer < ActiveRecord::Migration
  def change
    add_column :venues, :times, :string
    add_column :offers, :times, :string
  end
end
