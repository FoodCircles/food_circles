class AddReferenceToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :reference, :string

  end
end
