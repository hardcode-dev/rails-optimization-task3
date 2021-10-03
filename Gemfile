source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails', '~> 5.2.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'mimemagic', '~> 0.3.10'
gem 'activerecord-import'

group :development, :test do
  gem 'rspec-rails', '~> 5.0.2'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'benchmark'
  gem 'memory_profiler'
  gem 'rack-mini-profiler'
  gem 'rubocop-performance', require: false
  gem 'ruby-prof'
  gem 'stackprof'
end

group :test do
  gem 'rspec-benchmark'
end
