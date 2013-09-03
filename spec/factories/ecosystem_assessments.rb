# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ecosystem_assessment do
    type ""
    title "MyString"
    language "MyString"
    english_title "MyString"
    published_year 1
    origin "MyString"
    url "MyString"
    is_final false
    license "MyString"
  end
end
