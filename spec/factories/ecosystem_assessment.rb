# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ecosystem_assessment do
    resource_type "Literature"
    title "Example ecosystem assessment title"
    language "English"
    english_title "English title"
    published_year 2013
    origin "this is a origin"
    url "http://www.example.org"
    is_final false
  end
end
