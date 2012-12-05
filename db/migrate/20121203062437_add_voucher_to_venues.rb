class AddVoucherToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :voucher, :string , :default => 5

  end
end
