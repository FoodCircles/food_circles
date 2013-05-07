# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
venue = Venue.create(:name => "Georgio's pizza")
Offer.create(:name => "Free Desserts", :venue => venue)
venue = Venue.create(:name => "Hopcat")
Offer.create(:name => "Free Appetizers", :venue => venue)
venue = Venue.create(:name => "Sanchez Bistro")
Offer.create(:name => "Free Loaded Crack Fries", :venue => venue)

