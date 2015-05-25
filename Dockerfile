FROM ruby:2.0.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev libsqlite3-dev qt5-default libqt5webkit5-dev ssmtp
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY config/database.docker.yml config/database.yml
COPY config/elasticsearch.docker.yml config/elasticsearch.yml
COPY config/redis.docker.yml config/redis.yml
ADD . /app


