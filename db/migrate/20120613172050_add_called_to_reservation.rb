class AddCalledToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :called, :boolean, :default => false

  end
end
