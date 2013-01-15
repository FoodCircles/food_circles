class DropContactTypes < ActiveRecord::Migration
  def up
    drop_table :contact_types
    drop_table :contacts
  end

  def down
  end
end
