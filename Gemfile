# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.4'

gem 'activerecord-import'
gem 'bootsnap', require: false
gem 'flamegraph'
gem 'json-stream'
gem 'kaminari'
gem 'meta_request'
gem 'pg'
gem 'puma'
gem 'rack-mini-profiler'
gem 'rails', '~> 7'
gem 'rubocop-rails', require: false
gem 'sprockets-rails'
gem 'yajl-ruby', require: 'yajl'
gem "pghero"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'benchmark'
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'memory_profiler'
  gem 'rubocop-performance'
  gem 'ruby-prof'
  gem 'stackprof'
  gem 'strong_migrations'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen'
  gem 'web-console'
end

group :test do
  gem 'minitest-power_assert'
  gem 'capybara'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem 'sqlite3'
  gem 'rspec-benchmark'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
