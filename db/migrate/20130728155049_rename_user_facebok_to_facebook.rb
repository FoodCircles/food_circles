class RenameUserFacebokToFacebook < ActiveRecord::Migration
  def change
    rename_column :users, :facebok_token, :facebook_token
    
  end
end
