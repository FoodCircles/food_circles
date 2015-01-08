class AddActiveToCharities < ActiveRecord::Migration
  def change
    add_column :charities, :active, :boolean, default:true
  end
end
