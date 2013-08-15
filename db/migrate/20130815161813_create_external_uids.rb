class CreateExternalUids < ActiveRecord::Migration
  def change
    create_table :external_uids do |t|
      t.references :user
      t.string :uid

      t.timestamps
    end
  end
end
