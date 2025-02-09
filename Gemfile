source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.4'

gem 'rails', '~> 7'
gem 'pg'
gem 'puma'
gem 'bootsnap', require: false
gem 'yajl-ruby', require: 'yajl'
gem 'json-stream'
gem 'activerecord-import'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'benchmark'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'memory_profiler'
  gem 'ruby-prof'
  gem 'stackprof'
  gem "strong_migrations"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console'
  gem 'listen'
end

group :test do
  gem 'minitest-power_assert'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
