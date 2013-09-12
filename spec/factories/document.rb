require 'fileutils'

def get_example_file
  file_path = File.join(Rails.root, '/spec/fixtures/files/NL_Biodiversity.pdf')
  FileUtils.cp(file_path, "#{file_path}.copy.pdf")
  File.open("#{file_path}.copy.pdf")
end

def get_other_file
  file_path = File.join(Rails.root, '/spec/fixtures/files/IT_Biodiversity.pdf')
  FileUtils.cp(file_path, "#{file_path}.copy.pdf")
  File.open("#{file_path}.copy.pdf")
end

FactoryGirl.define do
  factory :document do
    site_id 1
    title "Titulo de Ejemplo"
    english_title "Example Article"
    author "Jon Arrien"
    # file File.read(File.join(Rails.root, '/spec/fixtures/files/IT_Biodiversity.pdf'))
    # file File.open(File.join(Rails.root, '/spec/fixtures/files/IT_Biodiversity.pdf'),'rb')
    # remote_file_url "http://www.eea.europa.eu/publications/biodiversity-monitoring-in-europe/at_download/file"
    file { get_example_file }
    language_ids [22,5]
    published_on '01/01/2013'
  end

  factory :other_document, parent: :document do
    file { get_other_file }
  end
end

