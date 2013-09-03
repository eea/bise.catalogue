# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    title "MyString"
    english_title "MyString"
    author "MyString"
    published_on "2013-04-30 11:25:37"
    language "MyString"
    source "MyString"
    approved false
    countries nil
    url "MyString"
    approved_at "2013-04-30 11:25:37"
  end
end
