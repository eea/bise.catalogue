# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site do
    name 'BISE'
    origin_url 'http://biodiversity.europa.eu'
    description 'This is a description for BISE site...'
  end
end
