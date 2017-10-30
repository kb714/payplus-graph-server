module ShopMutations
  Create = GraphQL::Relay::Mutation.define do
    name 'Create'
    description 'Create new shop'

    input_field :name, !types.String
    input_field :description, !types.String
    input_field :url, !types.String

    return_field :shop, SHOP_TYPE
    return_field :errors, types.String

    resolve -> (_object, input, ctx) do
      shop = ctx[:current_user].shops.new(input)
      if shop.save
        { shop: shop }
      else
        { errors: shop.errors.to_a }
      end
    end

  end
end