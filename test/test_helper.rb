ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  #parallelize(workers: :number_of_processors, with: :threads)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all


  # Add more helper methods to be used by all tests here...
  def is_logged_in?
      !session[:user_id].nil?
    end

    class ActionDispatch::IntegrationTest
       def log_in_as(user, password: "password")
         post login_url, params: {session: {username: user.username, password: password }}
      end
    end


  def is_admin_logged_in?
    !session[:admin_id].nil?
  end
end
