# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.find_or_create_by_email("wholcomb@synaptian.com")

venue = Venue.create(:name => "Georgio's pizza")
offer = Offer.create(:name => "Free Desserts", :venue => venue)
Voucher.create(offer: offer, start: Time.now, :end => Time.now + 2.years, total: 10, available: rand(11))
Payment.create(user: user, offer: offer, amount: 10)

venue = Venue.create(:name => "Hopcat")
offer = Offer.create(:name => "Free Appetizers", :venue => venue)
Voucher.create(offer: offer, start: Time.now, :end => Time.now + 2.years, total: 10, available: rand(11))
Payment.create(user: user, offer: offer, amount: 10)

venue = Venue.create(:name => "Sanchez Bistro")
offer = Offer.create(:name => "Free Loaded Crack Fries", :venue => venue)
Voucher.create(offer: offer, start: Time.now, :end => Time.now + 2.years, total: 10, available: rand(11))
Payment.create(user: user, offer: offer, amount: 10)

