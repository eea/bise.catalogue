source 'https://rubygems.org'
# ruby "1.9.3"


gem 'rails', '3.2.13'

gem 'rack'                    , '~> 1.4.5'

gem 'devise'
gem 'devise_ldap_authenticatable'

# DATABASES
gem 'sqlite3'
gem 'pg'

group :assets do
  gem 'sass-rails'            ,   '~> 3.2.3'
  gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS

  gem 'therubyracer'          ,    '~> 0.11.4'

  gem 'jquery-rails'
  gem 'jquery-ui-rails'
  gem 'yui-compressor'
  gem 'turbo-sprockets-rails3',    '~> 0.3.6'
  #gem 'jquery-fileupload-rails'
end

gem 'underscore-rails'

# Outside assets for production coffee handlers
gem 'coffee-rails'              , '~> 3.2.1'
gem 'uglifier'                  , '>= 1.0.3'
gem 'sanitize'

# Remote file uploading
gem "remotipart"

# Shared Mustache Templates
gem 'smt_rails'                 , :git => 'https://github.com/railsware/smt_rails.git'

# gem 'haml'
gem "haml-rails"

# TINYMCE WYSIWYG EDITOR
gem 'tinymce-rails'

# Advanced Search
gem 'tire', '>= 0.5.4'
gem 'ransack'

# TWITTER BOOTSTRAP
gem "twitter-bootstrap-rails"  # , :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
gem "font-awesome-rails"


gem 'rdf'                       , '~> 1.0'
gem 'rdf-isomorphic'            , '~> 1.0'
gem 'rdf-spec'
gem 'rdf-raptor'                , '~> 1.0.1'
gem 'rdf-virtuoso'              , git: 'https://github.com/jonarrien/rdf-virtuoso.git'
gem 'spira'                     , git: 'https://github.com/ruby-rdf/spira.git'

gem 'ffi'
gem 'sparql'


# DataObjects-backed repositories for RDF.rb
gem 'rdf-do'
gem 'do_postgres'


group :development do
  gem 'coffee-rails-source-maps'
  gem 'better_errors'

  # gem 'ruby-debug19'
  gem 'pry', '>= 0.9.10'
  gem 'pry-doc'
  gem 'pry-nav'
  gem 'pry-stack_explorer'
  gem 'pry-rails'
  gem 'pry-remote'

  gem 'rubocop'
end

group :development, :test do

  gem 'dotenv-rails'
  gem 'gem-ctags'

  # TEST
  gem "rspec-rails"
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'guard-zeus-client'

  gem 'shoulda'
  gem 'shoulda-matchers', :require => false
  # gem 'guard-livereload'

  # Documentation
  gem 'railroady'

end

group :production do
  gem "libv8"
end

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'      , '~> 2.15.5'
gem 'capistrano-rbenv', '1.0.5'


gem 'custom_error_message'
gem "will_paginate"
gem 'will_paginate-bootstrap'

gem 'acts-as-taggable-on'

gem 'simple_form'

# File Uploading
gem 'carrierwave'     , '~> 0.9.0'
gem 'docsplit'

