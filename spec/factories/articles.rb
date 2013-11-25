FactoryGirl.define do
  factory :article do
    site 1
    title "Example Article"
    english_title "Example Article in English"
    author "Jon Arrien"
    content "This is an example Article for testing..."
    language_ids [5]
    published_on "01/02/2013"
  end
end
