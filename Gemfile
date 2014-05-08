source 'https://rubygems.org'
# ruby "1.9.3"

gem 'rails'                   , '3.2.13'
gem 'rake'                    , '10.3.1'
gem 'rack'                    , '~> 1.4.5'
gem 'railties'                , '~> 3.2.13'

gem 'devise'                  , '~> 3.2'
gem 'devise_ldap_authenticatable'

# DATABASES
gem 'sqlite3'
gem 'pg'

gem 'inherited_resources'
gem 'has_scope'
gem 'responders'

group :assets do
  gem 'sass-rails'            ,   '~> 3.2.6'
  gem "less-rails"

  gem 'therubyracer'          , '~> 0.12.0', require: 'v8'

  gem 'jquery-rails'
  gem 'jquery-ui-rails'
  gem 'yui-compressor'
  gem 'turbo-sprockets-rails3',    '~> 0.3.6'
  #gem 'jquery-fileupload-rails'
end

gem 'underscore-rails'
gem 'best_in_place'             , '~> 2.1.0'

# Outside assets for production coffee handlers
gem 'coffee-rails'              , '~> 3.2.1'
gem 'uglifier'                  , '>= 1.0.3'
gem 'sanitize'

# Remote file uploading
gem "remotipart"

# Shared Mustache Templates
# gem 'smt_rails'                 , '~> 0.2.5' #github: 'railsware/smt_rails'

# gem 'haml'
gem "haml-rails"

# TINYMCE WYSIWYG EDITOR
gem 'tinymce-rails'

# Advanced Search
gem 'tire', '>= 0.5.4'
gem 'ransack'

# TWITTER BOOTSTRAP
gem "twitter-bootstrap-rails"  # , git: 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
gem "font-awesome-rails"



gem 'rdf'                       , '~> 1.1.3'
gem 'rdf-isomorphic'            , '~> 1.1'
gem 'rdf-spec'
gem 'rdf-raptor'                , '~> 1.0.1'
gem 'rdf-virtuoso'              , github: 'jonarrien/rdf-virtuoso'
gem 'spira'                     , '~> 0.7.1'

# JSON linked data
gem 'json-ld'

gem 'ffi'
gem 'sparql'


# DataObjects-backed repositories for RDF.rb
gem 'rdf-do'
#gem 'do_postgres'

gem 'tilt'                      , '~> 1.3'
gem 'activeadmin'               , github: 'gregbell/active_admin', branch: '0-6-stable'
# gem 'meta_search'              , '>= 1.1.0.pre'
# gem 'polyamorous', github: 'activerecord-hackery/polyamorous'
# gem 'ransack', github: 'activerecord-hackery/ransack'
# gem 'formtastic', github: 'justinfrench/formtastic'
# gem 'activeadmin', github: 'gregbell/active_admin', branch: '0-6-stable'
# gem 'activeadmin'               , '~> 0.6.2'


group :development do
  gem 'coffee-rails-source-maps'
  gem 'better_errors'

  # gem 'ruby-debug19'
  gem 'pry', '>= 0.9.10'
  gem 'pry-remote'
  gem 'pry-doc'
  gem 'pry-nav'
  # gem 'pry-debugger'
  # gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'pry-rails'

  gem 'rubocop'
end

group :development, :test do

  gem 'dotenv-rails'
  gem 'gem-ctags'

  gem "rspec-rails"
  gem 'cucumber'      , '1.2.5'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  # gem 'factory_girl_rails'
  gem 'capybara-webkit'
  gem 'capybara-screenshot'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'guard-zeus-client'

  gem 'shoulda'
  gem 'shoulda-matchers' , require: false
  # gem 'guard-livereload'

  # Documentation
  gem 'railroady'

end

gem 'factory_girl_rails'

group :production do
  # gem "libv8"
end

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'      , '~> 2.15.5'
gem 'capistrano-rbenv', '1.0.5'


gem 'custom_error_message'
# gem "will_paginate"
gem 'will_paginate'           , '3.0.3'
gem 'will_paginate-bootstrap' , '~> 0.2.5'

gem 'acts-as-taggable-on'

gem 'simple_form'

# File Uploading
gem 'carrierwave'     , '~> 0.9.0'
gem 'docsplit'

