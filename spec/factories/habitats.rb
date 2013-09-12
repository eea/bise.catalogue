# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :habitat do
    uri "http://eunis.europa.eu/habitats/1"
    code 1
    name "MyString"
    natura2000_code 1
    habitat_code "MyString"
    level 1
    originally_published_code 1
    description "MyString"
    comment "MyString"
    national_name "MyString"
  end
end
