source 'https://rubygems.org'
ruby '2.3.3'

gem 'dashing', :git => 'https://github.com/Shopify/dashing.git', :ref => '5b585d'
gem 'dotenv'
gem 'geocoder'
gem 'activesupport'
gem 'nokogiri'
gem 'rake'
gem 'twitter'
gem 'yelp'
gem 'jwt'
gem 'signet'
gem 'google-api-client', '= 0.9.pre3' # 0.9.pre5 inhibits VCR from recording response bodies
gem 'representable', '~> 2.3.0' #See: https://github.com/google/google-api-ruby-client/issues/314
gem 'eventmachine', '~> 1.0.8'

# so our Rakefile works everywhere
gem 'rspec'
gem 'jasmine'

group :development do
  gem 'guard-rspec'
end

group :development, :test do
  gem 'pry'
  gem 'vcr'
  gem 'webmock'
  gem 'rack-coffee'
end

group :test do
  gem 'capybara'
  gem 'timecop'
end
