class CreateExperienceTaggables < ActiveRecord::Migration
  def change
    create_table "experience_taggables", :force => true do |t|
      t.integer  "experience_tag_id"
      t.integer  "venue_id"
      t.datetime "created_at",   :null => false
      t.datetime "updated_at",   :null => false
    end
  end
end
