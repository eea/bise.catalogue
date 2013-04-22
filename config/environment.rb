# Load the rails application
require File.expand_path('../application', __FILE__)
require 'yaml'

# ES_CONFIG = Yaml.load_file("#{RAILS_ROOT}/config/elasticsearch.yml")
ES_CONFIG = YAML::load_file("#{Rails.root}/config/elasticsearch.yml")

# Initialize the rails application
Catalogue::Application.initialize!

