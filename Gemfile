source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'activerecord-import', '~> 1.4', require: false
gem 'bootsnap', '>= 1.1.0', require: false
gem 'oj'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'pghero'
gem 'pg_query', '~> 2.1', '>= 2.1.3'
gem 'rails', '~> 5.2.3'
gem "strong_migrations"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails'
  gem 'rspec-benchmark'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'guard-shell', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'benchmark-ips', '~> 2.10'
  gem 'kalibera', '~> 0.1.2'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'memory_profiler'
  gem 'ruby-prof'
  gem 'web-console', '>= 3.3.0'
  gem 'stackprof'
  gem 'rack-mini-profiler'
end

group :test do
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
