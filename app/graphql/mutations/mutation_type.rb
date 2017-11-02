MUTATION_TYPE = GraphQL::ObjectType.define do
  name 'Mutation'
  # Create
  field :createShop, function: Shop::Create.new
  field :updateShop, function: Shop::Update.new

  # Delete
  field :deleteShop, SHOP_TYPE do
    description 'Destroy existing Shop'

    argument :id, !types.ID

    resolve ->(_obj, args, ctx) {
      begin
        shop = ctx[:current_user].shops.find_by_id(args[:id])
        shop.destroy!
        shop
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new(e.record.errors.to_json)
      end
    }
  end
end