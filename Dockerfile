FROM ruby:2.6.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /rails-optimization-task3
WORKDIR /rails-optimization-task3
COPY Gemfile /rails-optimization-task3/Gemfile
COPY Gemfile.lock /rails-optimization-task3/Gemfile.lock
RUN bundle install
    COPY . /rails-optimization-task3

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
