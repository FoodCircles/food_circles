class ChangeNotificationsContentToTextFromString < ActiveRecord::Migration
  def up
      change_column :notifications, :content, :text
  end
  def down
      change_column :notifications, :content, :string
  end
end
