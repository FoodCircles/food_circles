class AddDealTypeToCategories < ActiveRecord::Migration
  def change
    rename_column :categories, :type, :deal_type
  end
end
