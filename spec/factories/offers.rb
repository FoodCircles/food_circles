# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
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
