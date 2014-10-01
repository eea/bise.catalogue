# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site do
    name "#{Faker::Lorem.word} Library"
    origin_url "http://#{Faker::Internet.slug}"
    description 'This is a description for BISE site...'
  end
end
