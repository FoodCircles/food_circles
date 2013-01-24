class AddFeemessageFeechargeApplyAbleToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :feemessage, :string  ,:default => "Enter fee mesage."

    add_column :venues, :feecharge, :decimal ,:default => 0.0

    add_column :venues, :apply_able, :boolean, :default => false

  end
end
