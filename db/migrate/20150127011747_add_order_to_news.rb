class AddOrderToNews < ActiveRecord::Migration
  def change
    add_column :news, :order, :integer
  end
end
