FactoryGirl.define do
  extend ActionDispatch::TestProcess
  factory :document do
    site_id 1
    title "Titulo de Ejemplo"
    english_title "Example Article"
    author "Jon Arrien"
    file Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/files/IT_Biodiversity.pdf'))
    language_ids [22,5]
    published_on '01/01/2013'
  end
end

