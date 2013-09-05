# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    login 'demouser'
    password 'demopass'
  end
end
