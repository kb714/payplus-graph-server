require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
include Warden::Test::Helpers

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_user
    Warden.test_mode!
    user = create(:user)
    login_as user, scope: :user
    user.confirmed_at = Time.now
    user.confirm!
    user.save
    user
  end
end
