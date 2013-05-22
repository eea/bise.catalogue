FactoryGirl.define do
    factory :document do |f|
        f.title "Example Article"
        f.author "Jon Arrien"
        f.file File.open('/Users/jon/Practical_Vim.pdf')
        # f.site Site.find(1)
        # f.languages Language.find(5)
    end
end
