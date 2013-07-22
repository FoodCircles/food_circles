class AddStateToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :state, :string
  end
end
