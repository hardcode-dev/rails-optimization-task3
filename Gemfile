source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'activerecord-import'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'oj'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.3'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'memory_profiler'
  gem 'rspec-rails'
  gem 'rspec-benchmark'
  gem 'ruby-prof'
  gem 'ruby-progressbar'
end
group :development do
  gem 'meta_request'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
end
gem 'pghero'
gem 'pg_query', '>= 2'
gem 'rack-mini-profiler', require: false
group :test do
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
