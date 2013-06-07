class AddInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :city, :string
    add_column :users, :zip, :integer
    add_column :users, :gender, :string
    add_column :users, :birthday, :datetime
  end
end
