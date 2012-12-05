class CreateRemindLists < ActiveRecord::Migration
  def change
    create_table :remind_lists do |t|
      t.string :phone
      t.string :email
      t.string :blah
      t.datetime :last_reminded

      t.timestamps
    end
  end
end
