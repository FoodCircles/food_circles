FactoryGirl.define do
  factory :user do
    email "terminator@foodcircles.net"
    password "pikachu"
    password_confirmation "pikachu"
    name "Arnold Schwarzenegger"
    phone "555-5555"
    admin true
  end

  factory :venue do
    name "Georgio's Gourmet Pizza"
    description "Georgios Pizza stands out from other pizza parlors with its affordability, ingredient ingenuity (58 flavors!), and its cool interiors."
    address "Ionia Avenue SW"
    city "Grand Rapids"
    zip "49503"
    neighborhood "Downtown"
    web "url: http://georgiosgourmetpizza.com/, phone_num: 616-356-4600"
    image_uid "venues/1_7"
    price 1
    circle_image_uid "venues/georgios.png"
    vouchers_available 10
    vouchers_total 10
  end

  factory :offer do
    name "2 free desserts"
    details "With purchase of at least 2 slices of pizza per person"
    min_diners 2
    available 10
    total 10
    price 1.5
    original_price 2
  end
end