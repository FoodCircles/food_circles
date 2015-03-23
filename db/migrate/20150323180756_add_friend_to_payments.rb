class AddFriendToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :friend, :string
  end
end
