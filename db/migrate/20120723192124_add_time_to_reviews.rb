class AddTimeToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :time, :integer
  end
end
