# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if !Rails.env.production? || !Rails.env.staging?
  Database::Factory.create_records(:users, "#{Rails.root}/yml/users.yml")
  Database::Factory.create_records(:venues, "#{Rails.root}/yml/venues.yml")
  Database::Factory.create_records(:offers, "#{Rails.root}/yml/offers.yml")
end