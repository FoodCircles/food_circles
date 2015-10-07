class AddVisibleFlagToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :visible, :boolean, default: true
  end
end
