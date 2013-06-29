# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if !Rails.env.production? || !Rails.env.staging?
  Database::Factory.create_records(User, "users.yml")
  Database::Factory.create_records(Venue, "venues.yml")
  Database::Factory.create_records(Offer, "offers.yml")
end
