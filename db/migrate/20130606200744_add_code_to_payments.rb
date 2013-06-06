class AddCodeToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :code, :string
  end
end
