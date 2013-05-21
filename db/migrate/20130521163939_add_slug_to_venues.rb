class AddSlugToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :slug, :string
    add_index :venues, :slug, unique: true
  end
end
