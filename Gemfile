source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby file: '.ruby-version'

gem 'rails', '~> 8.0.1'
gem 'pg'
gem 'puma'
gem 'listen'
gem 'bootsnap'
gem 'rack-mini-profiler'
gem 'rubocop', require: false
gem 'pghero'
gem 'benchmark'
gem 'ruby-prof'
gem 'stackprof'

group :development, :test do
  gem 'rspec-rails', '~> 7.1.1'
  gem 'factory_bot_rails', '~> 6.4.4'
  gem 'rails-controller-testing'
  gem 'rspec-rake'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
