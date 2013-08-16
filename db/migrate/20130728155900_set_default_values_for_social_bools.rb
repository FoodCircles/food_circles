class SetDefaultValuesForSocialBools < ActiveRecord::Migration
  def change
    change_column :users, :has_twitter, :boolean, :null => false, :default => false
    change_column :users, :has_facebook, :boolean,:null => false, :default => false
    
  end
end
