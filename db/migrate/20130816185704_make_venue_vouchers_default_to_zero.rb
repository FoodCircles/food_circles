class MakeVenueVouchersDefaultToZero < ActiveRecord::Migration
  def up
    change_column :venues, :vouchers_available, :integer, :default => 0
    change_column :venues, :vouchers_total, :integer, :default => 0
    Venue.where('vouchers_available IS NULL').update_all(:vouchers_available => 0)
    Venue.where('vouchers_total IS NULL').update_all(:vouchers_total => 0)
  end

  def down
    change_column_default :venues, :vouchers_available, nil
    change_column_default :venues, :vouchers_total, nil
  end
end
