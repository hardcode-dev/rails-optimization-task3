# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'activerecord-import'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'newrelic_rpm'
gem 'oj'
gem 'pg', '>= 0.18', '< 2.0'
gem 'pghero'
gem 'pg_query', '>= 0.9.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.3'

group :development, :test do
  gem 'benchmark', '0.1.0'
  gem 'benchmark-memory'
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'database_cleaner-active_record'
  gem 'factory_bot_rails'
  gem 'fasterer', '0.8.3'
  gem 'memory_profiler'
  gem 'rspec-benchmark'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'ruby-prof', '1.4.1'
  gem 'stackprof', '0.2.15'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'meta_request'
  gem 'rack-mini-profiler'
  gem 'standard'
  gem 'web-console', '>= 3.3.0'
end

group :test do
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
