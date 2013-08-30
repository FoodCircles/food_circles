class EnsureExistingVenuesAndOffersAreAlwaysOpen < ActiveRecord::Migration
  def up
    [Venue, Offer].each do |openable_klass|
      openable_klass.find_each do |openable|
        openable.ensure_always_open
      end
    end
  end

  def down
  end
end
