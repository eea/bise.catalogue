FROM ruby:2.0.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev libsqlite3-dev qt5-default libqt5webkit5-dev ssmtp
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
RUN bundle install
ADD . /app
COPY config/database.example.yml config/database.yml
COPY config/elasticsearch.example.yml config/elasticsearch.yml
COPY config/redis.example.yml config/redis.yml
ENV RAILS_ENV=production
RUN bundle exec rake assets:precompile
