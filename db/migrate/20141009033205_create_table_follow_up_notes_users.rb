class CreateTableFollowUpNotesUsers < ActiveRecord::Migration
  def up
    create_table :follow_up_notes_users, :id => false do |t|
      t.integer :follow_up_note_id
      t.integer :user_id
    end
  end

  def down
    drop_table :follow_up_notes_users
  end
end
