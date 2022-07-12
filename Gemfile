source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'bootsnap', '>= 1.1.0', require: false
gem 'dotenv-rails'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.3'

gem 'mimemagic', git: 'https://github.com/mimemagicrb/mimemagic', ref: '3543363026121ee28d98dfce4cb6366980c055ee'

group :development, :test do
  gem 'benchmark'
  gem 'benchmark-ips'
  gem 'bullet'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pghero'
  gem 'rack-mini-profiler'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara'
  gem 'rspec-benchmark'
  gem 'rspec-rails'
end

gem 'activerecord-import'
gem 'oj'
gem 'ruby-progressbar'
gem 'strong_migrations'
