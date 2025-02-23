source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby file: '.ruby-version'

gem 'rails', '~> 8.0.1'
gem "sprockets-rails"
gem 'pg'
gem 'puma'
gem 'listen'
gem 'bootsnap'
gem 'rack-mini-profiler'

gem 'pry'
gem 'oj'
gem 'activerecord-import'

# PG
gem 'pghero'
gem "pg_query"

group :development, :test do
  # ENV
  gem "dotenv-rails", require: "dotenv/load", groups: %i[development test]

  # RSpec
  gem 'rspec-rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'

  # Benchmarking
  gem 'ruby-prof'
  gem 'stackprof'
  gem 'memory_profiler'
  gem 'bullet'

  gem 'annotaterb'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
