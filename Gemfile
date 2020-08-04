# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'activerecord-import'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'oj'
gem 'pg', '>= 0.18', '< 2.0'
gem 'pghero'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.3'
# gem 'strong_migrations'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'rspec-benchmark'
  gem 'rspec-rails', '~> 3.8'
end

group :development do
  gem 'bullet'
  gem 'flamegraph'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'memory_profiler'
  gem 'meta_request'
  gem 'rack-mini-profiler'
  gem 'rubocop', '~> 0.88.0', require: false
  gem 'rubocop-performance', '~> 1.7.0', require: false
  gem 'rubocop-rails', '~> 2.7.0', require: false
  gem 'rubocop-rspec', '~> 1.42.0', require: false
  gem 'ruby-prof'
  gem 'stackprof'

  gem 'web-console', '>= 3.3.0'
end

group :test do
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
