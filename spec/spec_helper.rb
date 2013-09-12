require 'rubygems'

ENV["RAILS_ENV"] = 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'shoulda-matchers'
require 'capybara/rspec'
# require 'rspec/autorun'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|

  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  config.mock_with :rspec
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_examples = true #factoryGirl
  config.use_transactional_fixtures = false #fixtures

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"


  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller
  config.include Capybara::DSL

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    # Rake::Task["db:seed"].invoke
    load "#{Rails.root}/db/seeds.rb"
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    clean_es_indexes
  end

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


# This file is copied to spec/ when you run 'rails generate rspec:install'


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.


