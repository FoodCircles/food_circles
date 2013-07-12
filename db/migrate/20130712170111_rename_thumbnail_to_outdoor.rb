class RenameThumbnailToOutdoor < ActiveRecord::Migration
  def change    
    rename_column :venues, :thumbnail_image_uid, :outside_image_uid
  end
  
end
