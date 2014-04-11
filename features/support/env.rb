require 'rubygems'

require 'cucumber/rails'
require 'capybara-webkit'


Capybara.javascript_driver = :webkit
Capybara.default_selector = :css
Capybara.save_and_open_page_path = File.join(Rails.root, 'tmp/capybara')
# Capybara.default_wait_time = 10

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Before do
  load "#{Rails.root}/db/seeds.rb"
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.start
end

After do |scenario|
  DatabaseCleaner.clean
  clean_es_indexes
end

def clean_es_indexes
  Article.index.delete
  Document.index.delete
  Link.index.delete
  News.index.delete
  ProtectedArea.index.delete
  Habitat.index.delete
  Species.index.delete

  Article.create_elasticsearch_index
  Document.create_elasticsearch_index
  Link.create_elasticsearch_index
  News.create_elasticsearch_index
  ProtectedArea.create_elasticsearch_index
  Habitat.create_elasticsearch_index
  Species.create_elasticsearch_index
end

# You may also want to configure DatabaseCleaner to use different strategies for certain features and scenarios.
# See the DatabaseCleaner documentation for details. Example:
#
#   Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
#     # { :except => [:widgets] } may not do what you expect here
#     # as Cucumber::Rails::Database.javascript_strategy overrides
#     # this setting.
#     DatabaseCleaner.strategy = :truncation
#   end
#
#   Before('~@no-txn', '~@selenium', '~@culerity', '~@celerity', '~@javascript') do
#     DatabaseCleaner.strategy = :transaction
#   end
#

Cucumber::Rails::Database.javascript_strategy = :truncation


