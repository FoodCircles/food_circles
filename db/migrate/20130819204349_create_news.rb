class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.string :mobile_image_uid
      t.string :website_image_uid
      t.string :mobile_url
      t.string :website_url

      t.timestamps
    end
  end
end
