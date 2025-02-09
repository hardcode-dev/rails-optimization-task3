FROM ruby:2.6.3

# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    postgresql-client \
    git \
    vim \
    curl

# Set working directory
WORKDIR /app

# Install Rails
RUN gem install bundler -v '~> 2.0.0'

# Copy Gemfile and Gemfile.lock
COPY Gemfile* ./

# Install dependencies
RUN bundle config set --local without 'development test'
RUN bundle install
RUN bundle exec rails bin/setup

# Copy the rest of the application
COPY . .

# Expose port 3000
EXPOSE 3000

# Start the main process
CMD ["rails", "server", "-b", "0.0.0.0"]
