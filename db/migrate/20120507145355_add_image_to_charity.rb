class AddImageToCharity < ActiveRecord::Migration
  def change
    add_column :charities, :image_uid, :string
  end
end
