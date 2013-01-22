class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :group_name
      t.integer :group_size
      t.string :code
      t.datetime :time
      t.string :perk
      t.decimal :amount
      t.string :venue

      t.timestamps
    end
  end
end
