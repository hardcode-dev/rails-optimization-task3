source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby file: '.ruby-version'

gem 'rails', '~> 8.0.1'
gem 'pg'
gem 'puma'
gem 'listen'
gem 'bootsnap'
gem 'rack-mini-profiler'
gem 'sprockets-rails', :require => 'sprockets/railtie'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development do
  gem 'pghero'
  gem "pg_query", ">= 2"
  gem "ruby-prof"
  gem "memory_profiler"
end

group :development, :test do
  gem 'rspec-rails', '~> 7.0.0'
end
