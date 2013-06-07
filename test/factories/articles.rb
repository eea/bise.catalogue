FactoryGirl.define do
    factory :article do |f|
        f.title "Example Article"
        f.english_title "Example Article in English"
        f.author "Jon Arrien"
        f.content "This is an example Article for testing..."
    end
end
