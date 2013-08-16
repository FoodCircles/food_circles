class CreateStatus < ActiveRecord::Migration
  def change
    create_table "status", :force => true do |t|
      t.string   "status"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end
  end
end
