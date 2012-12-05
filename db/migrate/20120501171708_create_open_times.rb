class CreateOpenTimes < ActiveRecord::Migration
  def change
    create_table :open_times do |t|
      t.integer :openable_id
      t.string :openable_type
      t.integer :start
      t.integer :end
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
