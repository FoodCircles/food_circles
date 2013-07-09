class CreateLongTasks < ActiveRecord::Migration
  def change
    create_table "long_tasks", :force => true
  end
end
