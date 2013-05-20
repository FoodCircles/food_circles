class RenameEndTime < ActiveRecord::Migration
  def up
  end

  def down
  end

 def change
   change_table :vouchers do |t|
     t.rename :start, :start_date
     t.rename :end, :end_date
   end
 end
end
