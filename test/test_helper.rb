ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "capybara/rails"
require "rails/test_help"
require 'database_cleaner/active_record'

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end

module ActiveSupport
  class TestCase
    DatabaseCleaner.strategy = :truncation
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    setup do
      DatabaseCleaner.start
    end

    teardown do
      DatabaseCleaner.clean
    end
  end
end
