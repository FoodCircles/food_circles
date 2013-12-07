# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    user_id 1
    offer_id 1
    charity_id 1
  end
end
