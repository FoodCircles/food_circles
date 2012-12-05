class AddCircleImageToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :circle_image_uid, :string
  end
end
