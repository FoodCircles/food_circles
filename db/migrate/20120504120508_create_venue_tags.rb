class CreateVenueTags < ActiveRecord::Migration
  def change
    create_table :venue_tags do |t|
      t.string :name

      t.timestamps
    end
  end
end
