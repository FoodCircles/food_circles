class CreateCharityPhotos < ActiveRecord::Migration
  def change
    create_table :charity_photos do |t|
      t.attachment :photo
      t.integer :charity_id

      t.timestamps
    end
  end
end
