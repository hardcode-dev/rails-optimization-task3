FROM ruby:2.6.3-alpine

RUN apk update  && apk upgrade && apk add --update --no-cache \
  build-base libc-dev tzdata bash htop shared-mime-info \
  postgresql-dev postgresql-client

WORKDIR /opt/app

COPY Gemfile* ./

RUN gem install bundler -v 2.0.2
RUN bundle install

COPY . .
