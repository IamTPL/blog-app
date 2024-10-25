ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def log_in_as(author)
    post login_url, params: { session: { email: author.email, password: 'password' } }
  end

  def login_user(user)
    visit login_url
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_on 'Log in'
  end
end
