source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 6'

group :development, :test do
  gem 'byebug'
  gem 'pry'
  gem 'pry-rails'
  gem 'rack-mini-profiler', require: false
  gem 'rspec-benchmark'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'ruby-prof'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
end
