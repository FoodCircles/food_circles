class AddExtraToCharities < ActiveRecord::Migration
  def change
    add_column :charities, :charity_type, :string
    add_column :charities, :subdomain, :string
    add_column :charities, :use_funds, :string
    add_column :charities, :logo_uid, :string
    add_column :charities, :photo_uid, :string
  end
end
