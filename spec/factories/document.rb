FactoryGirl.define do
    factory :document do |f|
        f.site_id 1
        f.title "Titulo de Ejemplo"
        f.english_title "Example Article"
        f.author "Jon Arrien"
        f.file File.open('/Users/jon/Dropbox/PDF/coffeescript.pdf')
        f.language_ids [22,5]
    end
end
