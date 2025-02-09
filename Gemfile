source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.4.1'

gem 'rails', '~> 8.0.1'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'bootsnap', '>= 1.1.0', require: false

gem 'sprockets-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '~> 4.2.1'
  gem 'listen', '~> 3.9.0'
end

group :development, :test do
  gem 'rspec-rails', '~> 7.1.1'
  gem 'factory_bot_rails', '~> 6.4.4'
  gem 'rails-controller-testing'
  gem 'rspec-rake'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
