class AddVouchersToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :vouchers_available, :integer
    add_column :venues, :vouchers_total, :integer
  end
end
