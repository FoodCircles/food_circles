class RenameCircleImageAndAddOutsideImageToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :timeline_image_uid,  :string
    
    rename_column :venues, :circle_image_uid, :restaurant_tile_image_uid
    
  end
  
end
