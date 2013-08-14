class CreateSocialLinks < ActiveRecord::Migration
  def change
    create_table :social_links do |t|
      t.references :venue
      t.string :url

      t.timestamps
    end
  end
end
