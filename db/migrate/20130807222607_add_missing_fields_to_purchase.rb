class AddMissingFieldsToPurchase < ActiveRecord::Migration
  def change
    add_column :payments, :num_diners, :integer
    add_column :payments, :occasion, :string
    add_column :payments, :confirmed, :boolean
    add_column :payments, :time_confirmed, :datetime
    add_column :payments, :coupon, :string
    add_column :payments, :name, :string
    add_column :payments, :phone, :string
    add_column :payments, :called, :boolean
    
  end
end
