require 'rails_helper'

describe Shop do
  it 'Create a shop' do
    shop = Shop.new(name: 'test', description: 'test description', url: 'https://www.acvp.cl')

    expect(shop).to be_valid
  end
end
