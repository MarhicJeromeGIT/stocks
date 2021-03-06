source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
#gem 'puma', '~> 3.0'
# uses unicorn
#gem 'unicorn'
# Use SCSS for stylesheets
gem 'sass-rails' 
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
group :development do
  gem 'capistrano', '~> 3.6'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-passenger'
 # gem 'capistrano-unicorn', :require => false
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'simplecov', :require => false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "haml-rails", "~> 0.9"
gem 'bootstrap-sass', '~> 3.3.6'
gem 'httparty'
#cron job management
gem 'whenever', :require => false
# load variables from .env into ENV
gem 'dotenv-rails'
gem 'mysql2'
gem 'jquery-datatables-rails'

# user management
gem 'devise'
# policies management
gem "pundit"
# ruby syntax checks
gem 'rubocop', require: false
# Swagger API doc
gem 'swagger-blocks'
gem 'omniauth'
gem 'omniauth-github', github: 'intridea/omniauth-github'
gem 'rack-cors', :require => 'rack/cors'
gem 'ejs' # fixes travis error
gem "slack-notifier"
gem 'omniauth-facebook'
# Elastic search gems
gem 'elasticsearch-model'
gem 'elasticsearch-rails'
# React - ES6
gem "react-rails"

