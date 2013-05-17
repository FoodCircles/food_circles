class AddQuantitiesToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :available, :integer
    add_column :offers, :total, :integer
  end
end
