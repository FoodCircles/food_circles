class UpdatePayments < ActiveRecord::Migration
  def up
    rename_column :payments, :charity, :charity_id
  end

  def down
    rename_column :payments, :charity_id, :charity
  end
end
