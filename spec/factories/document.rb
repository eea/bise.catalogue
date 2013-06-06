FactoryGirl.define do
    factory :document do |f|
        f.site_id 1
        f.title "Example Article"
        f.author "Jon Arrien"
        f.file File.open('/Users/jon/Practical_Vim.pdf')
        # f.site Site.find(1)
        # f.languages Language.find(5)
        # f.language_ids = [1,2,3,4]
        f.languages { |l| [l.association(:document)] }
        # f.association(:languages, :factory => :language)
    end
end
