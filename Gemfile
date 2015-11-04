source 'https://rubygems.org'

ruby '2.2.3'

gem 'rails', '4.2.4'
gem 'rails-i18n'

gem 'passenger'
gem 'rack-status'

gem 'pg'
gem 'uniquify'
gem 'paranoia'
gem 'cancancan'

gem 'activeadmin', github: 'activeadmin'
gem 'responsive_active_admin'

gem 'turbolinks'
gem 'jquery-ui-rails'
gem 'momentjs-rails'
gem 'slim'
gem 'to_spreadsheet', github: 'farukca/to_spreadsheet', ref: '922b63'

gem 'sass-rails'
gem 'font-awesome-sass'

gem 'sucker_punch'
gem 'facets', require: false

gem 'bourbon'
gem 'bitters'
gem 'neat', '>= 1.7.0'
gem 'refills' #, github: 'thoughtbot/refills'

gem 'devise'
gem 'devise-i18n'

gem 'uglifier'
gem 'jbuilder'
gem 'google_drive'
gem 'google-api-client'

gem 'icalendar'

gem 'exception_notification'

gem 'faraday'
gem 'faraday-cookie_jar'

group :production do
  gem 'rails_12factor'
  gem 'dalli'
  gem 'skylight'
end

group :development do
  gem 'rack-livereload'
  gem 'guard-livereload', require: false
  gem 'quiet_assets'
  gem 'letter_opener'
end

group :development, :test do
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'capybara'
  gem 'capybara-email'
  gem 'factory_girl_rails'
  gem 'faker'
end
