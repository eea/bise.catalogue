# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :habitat do
    uri "http://eunis.europa.eu/habitats/1"
    code 1
    name "Example habitat's name"
    natura2000_code 1
    habitat_code "ES000025"
    level 1
    originally_published_code 1
    description "Example description"
    comment "Example comment"
    national_name "Example national name"
  end
end
