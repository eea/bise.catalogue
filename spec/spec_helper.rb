require 'rubygems'

ENV["RAILS_ENV"] = 'test'
require File.expand_path("../../config/environment", __FILE__)

require 'devise'
require 'rspec/rails'
require 'shoulda-matchers'
require 'capybara/rspec'
# require 'capybara-webkit'
# require 'rspec/autorun'

# Capybara.javascript_driver = :webkit
# Capybara.default_wait_time = 10
# Capybara.default_selector = :css
# Capybara.save_and_open_page_path = 'tmp/capybara'
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|

  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller
  config.include Devise::TestHelpers, type: :view
  config.include Capybara::DSL
  config.extend ControllerMacros, :type => :controller

  # ## Mock Framework
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # config.filter_run focus: true
  # config.run_all_when_everything_filtered = false

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_examples = true  # factoryGirl
  config.use_transactional_fixtures = false # fixtures

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.before(:all) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
    load "#{Rails.root}/db/seeds.rb"
  end

  config.after(:each) do
    DatabaseCleaner.clean
    clean_es_indexes
  end

end


def clean_es_indexes
  %w(Article Document Link News ProtectedArea Habitat Species).each do |obj|
    eval(obj).index.delete
    eval(obj).create_elasticsearch_index
  end
end

