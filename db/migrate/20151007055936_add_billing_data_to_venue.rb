class AddBillingDataToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :first_name, :string
    add_column :venues, :last_name, :string
    add_column :venues, :cc_num, :text
    add_column :venues, :cc_expm, :string
    add_column :venues, :cc_expy, :string
    add_column :venues, :cc_cvv2, :string
    add_column :venues, :cc_zip, :string
    add_column :venues, :facebook, :string
    add_column :venues, :twitter, :string
    add_column :venues, :instagram, :string
    add_column :venues, :social_media_email, :string
  end
end
