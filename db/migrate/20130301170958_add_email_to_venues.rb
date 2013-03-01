class AddEmailToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :email, :string, :default => "venue@example.com"

  end
end
