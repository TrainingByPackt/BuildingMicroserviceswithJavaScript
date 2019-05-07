FROM ruby:2.3.1

RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev

RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN bundle install
ADD . /app
