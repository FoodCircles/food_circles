class ModifyAndAddVenueImages < ActiveRecord::Migration
  def change
    add_column :venues, :thumbnail_image_uid,  :string
    
    rename_column :venues, :image_uid, :main_image_uid
    
  end
end
