class AddSocialTokensToUser < ActiveRecord::Migration
  def change
    add_column :users, :twitter_secret, :string
    add_column :users, :twitter_token, :string
    add_column :users, :facebook_secret, :string
    add_column :users, :facebok_token, :string
    add_column :users, :has_twitter, :boolean
    add_column :users, :has_facebook, :boolean
    
  end
end
