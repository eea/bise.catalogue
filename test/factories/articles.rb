FactoryGirl.define do
    factory :article do |f|
        f.site_id 1
        f.title "Example Article"
        f.english_title "Example Article in English"
        f.author "Jon Arrien"
        f.content "This is an example Article for testing..."
        f.language_ids [22,5]
    end
end
