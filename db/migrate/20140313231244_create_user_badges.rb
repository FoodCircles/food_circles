class CreateUserBadges < ActiveRecord::Migration
  def change
    create_table :user_badges do |t|
      t.references :user
      t.references :badge
      t.boolean :sent_email

      t.timestamps
    end
    add_index :user_badges, :user_id
    add_index :user_badges, :badge_id
  end
end
