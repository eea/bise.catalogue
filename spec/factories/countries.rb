# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :country do
    name "Country example name"
    code "IT"
    eu15 false
    eu25 false
    eu27 false
    eu28 false
    eea false
  end
end
