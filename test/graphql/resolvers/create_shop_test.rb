require 'test_helper'

class Resolvers::CreateShopTest < ActiveSupport::TestCase
  def perform(args = {})
    Resolvers::CreateShop.new.call(nil, args, {})
  end

  test 'creating new shop' do
    shop = perform(
        name: 'example',
        url: 'http://example.com',
        description: 'description',
    )

    assert shop.persisted?
    assert_equal shop.name, 'example'
    assert_equal shop.description, 'description'
    assert_equal shop.url, 'http://example.com'
  end
end