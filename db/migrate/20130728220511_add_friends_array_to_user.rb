class AddFriendsArrayToUser < ActiveRecord::Migration
  def change
    add_column :users, :friends, :text
    rename_column :users, :uid, :twitter_uid
    add_column :users, :facebook_uid, :string
    
    
  end
end
