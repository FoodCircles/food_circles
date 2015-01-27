class AddOrderToCharities < ActiveRecord::Migration
  def change
    add_column :charities, :order, :integer
  end
end
