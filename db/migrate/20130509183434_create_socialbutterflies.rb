class CreateSocialbutterflies < ActiveRecord::Migration
  def change
    create_table :socialbutterflies do |t|
      t.string :facebook

      t.timestamps
    end
  end
end
