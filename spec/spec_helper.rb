ENV['RACK_ENV'] = 'test'
ENV['JOB_PATH'] = '/no/where/to/go'

require 'dashing'
require 'capybara/rspec'
require 'capybara/dsl'
require 'vcr'
require 'pry'
require 'coveralls'
Coveralls.wear!

Dir.glob(File.expand_path("../../lib/*.rb", __FILE__)).each { |file| require file }

Capybara.app = Sinatra::Application

VCR.configure do |c|
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.cassette_library_dir = 'spec/fixtures/cassettes'
end

