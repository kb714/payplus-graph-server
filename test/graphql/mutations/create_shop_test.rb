require 'test_helper'
include Warden::Test::Helpers

class Mutations::CreateShopTest < ActiveSupport::TestCase

  def perform(args = {})
    Mutations::CreateShop.new.call(nil, args, current_user: login_user)
  end

  #test 'creating new shop' do
  #  current_user = login_user
  #  current_user.shops = perform(
  #    name: 'example',
  #    url: 'http://example.com',
  #    description: 'description'
  #  )
#
  #  assert current_user.shops.persisted?
  #  assert_equal current_user.shops.name, 'example'
  #  assert_equal current_user.shops.description, 'description'
  #  assert_equal current_user.shops.url, 'http://example.com'
  #end
end
