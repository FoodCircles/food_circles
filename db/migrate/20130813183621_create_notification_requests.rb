class CreateNotificationRequests < ActiveRecord::Migration
  def change
    create_table :notification_requests do |t|
      t.references :user
      t.references :venue

      t.timestamps
    end
  end
end
