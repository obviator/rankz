source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'duktape'
# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# # Bootstrap 4
# gem 'bootstrap', '~> 4.1.1'

# jQuery
# gem 'jquery-rails'
# gem 'jquery-ui-rails'

# Use slug instead of ID
gem 'friendly_id', '~> 5.2.0'

# # Font awesome
# gem 'font-awesome-rails'

# User roles management
gem 'rolify', '~> 5.2.0'

# Authorisation management
gem 'pundit'

# User registration management
gem 'devise', '~> 4.4.3'

# # Devise views fap-views', '~> 0.0.11'

# Webpacker
# gem 'webpacker'

#Best-In-Place AJAX editor
# gem 'best_in_place', '~> 3.0.3'

# Round number manegement
gem 'acts_as_list'

# Dentaku
gem 'dentaku'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # RSpec
  gem 'rspec-rails', '~> 3.7'

  # replaces Rails' default fixtures
  gem 'factory_bot_rails', '~> 4.0'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'rails_real_favicon'
  # Monitor file changes on windows (for Guard)
  gem 'wdm', '>= 0.1.0' if Gem.win_platform?
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'

  # watches your application and tests and runs specs for you automatically when it detects changes.
  gem 'guard-rspec', require: false
  # opens your default web browser upon failed integration specs to show you what your application is rendering.
  gem 'launchy'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
