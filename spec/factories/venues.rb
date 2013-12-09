# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :venue do
    name "Georgio's Gourmet Pizza"
    email "burger@test.com"
    description "Georgios Pizza stands out from other pizza parlors with its affordability, ingredient ingenuity (58 flavors!), and its cool interiors."
    address "Ionia Avenue SW"
    city "Grand Rapids"
    zip "49503"
    neighborhood "Downtown"
    web "url: http://georgiosgourmetpizza.com/, phone_num: 616-356-4600"
    price 1
    vouchers_available 10
    vouchers_total 10
    latlon RGeo::Cartesian.factory.point(0,0)
  end

end
