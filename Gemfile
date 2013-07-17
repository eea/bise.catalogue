source 'https://rubygems.org'
ruby "1.9.3"


# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem 'rails', '3.2.13'

gem 'rack'      #, '1.4.1'
gem 'zeus'

# DATABASES
gem 'sqlite3'
gem 'pg'



# Gems used only for assets and not required
# in production environments by default.
group :assets do

    gem 'sass-rails'            ,   '~> 3.2.3'
    # gem 'mustache'
    # gem 'mustache_rails3'
    #gem 'mustache-rails', :require => 'mustache/railtie'

    gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS

    gem 'therubyracer'          ,    '~> 0.11.4'

    gem 'jquery-rails'
    gem 'jquery-ui-rails'
    gem 'yui-compressor'
    #gem 'jquery-fileupload-rails'

end

gem 'underscore-rails'

# Outside assets for production coffee handlers
gem 'coffee-rails'              , '~> 3.2.1'
gem 'uglifier'                  , '>= 1.0.3'

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


# RDF.rb
# gem 'linkeddata'
# gem 'equivalent-xml'

gem 'rdf'                       , '~> 1.0'
gem 'rdf-isomorphic'            , '~> 1.0'
gem 'rdf-spec'
gem 'rdf-raptor'                , '~> 1.0.1'    # , '~> 0.4.2'
gem 'rdf-virtuoso'              , git: 'https://github.com/jonarrien/rdf-virtuoso.git'

# gem 'spira'                     , '~> 0.5.0'
gem 'spira'                     , git: 'https://github.com/ruby-rdf/spira.git'

# gem 'rdf-gzip'
# gem 'rdf-xml'
gem 'ffi'
gem 'sparql'
# gem 'sparql-client'


# DataObjects-backed repositories for RDF.rb
gem 'rdf-do'
gem 'do_postgres'

# gem 'iconv'

group :development do
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

    # To use debugger
    # gem 'debugger'

    # gem 'ruby-prof'
    # gem 'test-unit'
    # gem 'rspec'

    gem 'gem-ctags'

    # TEST
    gem "rspec-rails"
    gem 'cucumber-rails', :require => false

    # Documentation
    gem 'railroady'
    # gem 'RedCloth'

end

group :test do
    gem 'factory_girl_rails'
    gem 'capybara'
    gem 'guard-rspec'
    gem 'guard-cucumber'
    # gem 'guard-zeus'
    gem 'guard-zeus-client'
    gem 'database_cleaner'

    gem 'shoulda'
    gem 'shoulda-matchers', :require => false
    # gem 'guard-livereload'
end

group :production do
  gem "libv8"
  # gem "therubyracer", :require => 'v8'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

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
gem 'carrierwave'
gem 'docsplit'

# Versioning
# gem 'vestal_versions', :git => 'git://github.com/laserlemon/vestal_versions'
