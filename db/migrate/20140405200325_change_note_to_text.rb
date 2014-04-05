class ChangeNoteToText < ActiveRecord::Migration
  def up
      change_column :follow_up_notes, :note, :text
  end
  def down
      change_column :follow_up_notes, :note, :string
  end
end
