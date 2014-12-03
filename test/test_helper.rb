ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'simplecov'
SimpleCov.start

include ActionDispatch::TestProcess
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  CarrierWave.root = 'test/fixtures'

  # Add more helper methods to be used by all tests here...
end
