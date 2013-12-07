

FactoryGirl.define do
  factory :user do
    email "terminator@foodcircles.net"
    password "pikachu"
    password_confirmation "pikachu"
    name "Arnold Schwarzenegger"
    phone "555-5555"
    admin true
  end
end
