class AddTypeToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :type, :string
  end
end
