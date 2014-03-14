# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_badge do
    user nil
    badge nil
    sent_email false
  end
end
