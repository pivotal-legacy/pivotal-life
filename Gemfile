source 'https://rubygems.org'

ruby '2.0.0'

gem 'citibikenyc'
gem 'dashing'
gem 'dotenv'
gem 'geocoder'
gem 'activesupport'
gem 'nokogiri'
gem 'rake'
gem 'twitter'

gem 'coveralls', require: false

gem 'rspec' # so our Rakefile works everywhere
gem 'jasmine'

group :development do
  gem 'heroku_san'
  gem 'guard-rspec'
end

group :development, :test do
  gem 'pry'
  gem 'vcr'
  gem 'webmock', '<1.16'
  gem 'rack-coffee'
end

group :test do
  gem 'capybara'
  gem 'timecop'
end

