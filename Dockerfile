FROM ruby:2.0.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev libsqlite3-dev qt5-default libqt5webkit5-dev ssmtp
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
RUN bundle install

ADD Rakefile /app/
ADD app /app/app
ADD bin /app/bin
ADD config /app/config
ADD db /app/db
ADD features /app/features
ADD lib /app/lib
ADD public /app/public
ADD script /app/script
ADD spec /app/spec
ADD vendor /app/vendor

COPY config/database.example.yml /app/config/database.yml
COPY config/elasticsearch.example.yml /app/config/elasticsearch.yml
COPY config/redis.example.yml /app/config/redis.yml

RUN RAILS_ENV=production bundle exec rake assets:precompile --trace
RUN apt-get purge -y elasticsearch
CMD ["rails", "server", "-b", "0.0.0.0"]
