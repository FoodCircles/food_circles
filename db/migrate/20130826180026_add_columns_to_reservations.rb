class AddColumnsToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :amount, :float
    add_column :reservations, :code, :string
  end
end
