FROM ruby:2.0.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev libsqlite3-dev qt5-default libqt5webkit5-dev
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
RUN bundle install
ADD . /app


