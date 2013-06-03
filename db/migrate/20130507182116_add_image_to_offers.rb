class AddImageToOffers < ActiveRecord::Migration
  def change
  end

  def self.up
    # add_attachment :offers, :image
    add_column :offers, :image_file_name, :string
    add_column :offers, :image_content_type, :string
    add_column :offers, :image_file_size, :integer
    add_column :offers, :image_updated_at, :datetime 
  end

  def self.down
    remove_attachment :offers, :image
  end
end
