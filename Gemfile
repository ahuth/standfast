# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.3.3'

gem 'bootstrap', '~> 4.0.0.alpha5'
gem 'browserify-rails', '~> 3.4'
gem 'devise', '~> 4.2'
gem 'griddler', '~> 1.3'
gem 'griddler-sendgrid', '~> 0.0'
gem 'pg', '~> 0.19'
gem 'puma', '~> 3.6'
gem 'rack-timeout', '~> 0.4'
gem 'rails', '~> 5.0.1.rc2'
gem 'redcarpet', '~> 3.3'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 3.0.4'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'pry-byebug', '~> 3.4'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'rubocop', '~> 0.46', require: false
end

group :test do
  gem 'shoulda-matchers', '~> 3.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
