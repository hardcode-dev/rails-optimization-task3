source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby file: '.ruby-version'

gem 'rails', '~> 8.0.1'
gem 'pg'
gem 'puma'
gem 'listen'
gem 'bootsnap'
gem 'rack-mini-profiler'
gem 'pry'
gem 'oj'
gem 'activerecord-import'

group :development, :test do
  # RSpec
  gem 'rspec-rails'
  gem 'rspec-benchmark'

  # Benchmarking
  gem 'ruby-prof'
  gem 'stackprof'
  gem 'memory_profiler'

  gem 'annotaterb'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
