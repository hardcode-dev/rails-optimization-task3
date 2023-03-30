# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.6'

gem 'rails', '~> 5.2.3'

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'mimemagic', '~> 0.3.10'

gem 'activerecord-import'

gem 'fast_jsonparser'
gem 'oj'

gem 'strong_migrations'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'benchmark', '~> 0.2.1'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-benchmark', '~> 0.6.0'
  # gem 'rspec-rails', '~> 5.0.0'

  gem 'bullet'
  gem 'pghero'
  gem 'pg_query', '>= 2'

  gem 'memory_profiler'
  gem 'rack-mini-profiler', require: false
  gem 'stackprof'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
end

group :test do
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
