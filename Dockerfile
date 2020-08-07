FROM ruby:2.6.3-alpine

ENV APP_PATH /var/www/schedule_app
ENV TZ Europe/Moscow
ENV LANG ru_RU.UTF-8
ENV LANGUAGE ru_RU.UTF-8
ENV LC_ALL ru_RU.UTF-8

RUN apk update && apk add --no-cache yarn \
  build-base curl-dev git postgresql-dev \
  yaml-dev zlib-dev nodejs gcc g++ make busybox ctags \
  tzdata
  
RUN cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime && \
  echo "Europe/Moscow" >  /etc/timezone

RUN mkdir -p $APP_PATH

WORKDIR $APP_PATH

COPY Gemfile $APP_PATH/Gemfile
COPY Gemfile.lock $APP_PATH/Gemfile.lock
COPY package.json $APP_PATH/package.json

RUN yarn global add node-sass
RUN yarn
RUN gem install bundler:2.0.2
RUN bundle install

COPY . $APP_PATH

EXPOSE 3000/tcp
#CMD sh -c "bin/setup"
#CMD sh -c "bundle exec rails server -b 0.0.0.0 -p 3000"
