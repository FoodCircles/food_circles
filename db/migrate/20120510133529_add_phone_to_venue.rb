class AddPhoneToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :phone, :string

  end
end
