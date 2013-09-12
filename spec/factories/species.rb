# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :species do
    uri "http://eunis.europa.eu/species/1"
    binomial_name 'Canis Lupus'
  end
end
