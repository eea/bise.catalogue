# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    site_id 1
    title "Link title"
    english_title "English link title"
    author "Jon Arrien"
    published_on "2013-04-30 11:25:37"
    language_ids [22,5]
    url "http://www.example.org"

    approved false
    approved_at "2013-04-30 11:25:37"
  end
end
