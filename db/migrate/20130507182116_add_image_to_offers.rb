class AddImageToOffers < ActiveRecord::Migration
  def change
  end

  def self.up
    add_attachment :offers, :image
  end

  def self.down
    remove_attachment :offers, :image
  end
end
