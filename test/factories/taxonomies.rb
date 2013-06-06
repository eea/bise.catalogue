# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :taxonomy do
    code 1
    name "MyString"
    level "MyString"
    parent nil
  end
end
