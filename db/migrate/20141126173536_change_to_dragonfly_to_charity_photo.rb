class ChangeToDragonflyToCharityPhoto < ActiveRecord::Migration
  def up
    remove_column :charity_photos, :photo_file_name
    remove_column :charity_photos, :photo_content_type
    remove_column :charity_photos, :photo_file_size
    remove_column :charity_photos, :photo_updated_at
    add_column :charity_photos, :photo_uid, :string
  end

  def down
    remove_column :charity_photos, :photo_uid
    add_column :charity_photos, :photo, :attachment
  end
end
