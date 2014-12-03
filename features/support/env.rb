# require 'rubygems'
require 'cucumber/rails'
require 'dotenv'
require 'sidekiq/testing'
# require 'capybara-webkit'
#


Capybara.javascript_driver = :webkit
Capybara.default_selector = :css
Capybara.save_and_open_page_path = 'tmp/capybara'


# Capybara.default_wait_time = 10

ActionController::Base.allow_rescue = false

begin
  require 'database_cleaner'
  require 'database_cleaner/cucumber'
  DatabaseCleaner.strategy = :transaction
  # DatabaseCleaner.clean_with(:truncation)
  %w(Article Document Link News ProtectedArea Habitat Species).each do |obj|
    eval(obj).index.delete
    eval(obj).create_elasticsearch_index
  end
  Dotenv.load(Rails.root.join('Dotenv.env'))
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

# def clean_es_indexes
#   %w(Article Document Link News ProtectedArea Habitat Species).each do |obj|
#     eval(obj).index.delete
#     eval(obj).create_elasticsearch_index
#   end
# end

Cucumber::Rails::Database.javascript_strategy = :truncation


