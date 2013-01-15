class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :content
      t.string :ticker

      t.timestamps
    end
  end
end
