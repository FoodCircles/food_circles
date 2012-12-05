class AddActiveToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :active, :boolean, :default => true
  end
end
