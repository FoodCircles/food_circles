class AddRatingToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :rating, :float
  end
end
