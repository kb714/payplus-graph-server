MUTATION_TYPE = GraphQL::ObjectType.define do
  name 'Mutation'

 field :createShop, SHOP_TYPE do
    description 'Create new shop'

    argument :input, SHOP_INPUT_TYPE

    resolve -> (_object, input, ctx) {
      begin
        shop = ctx[:current_user].shops.create!(input[:input].to_h)
        # on success, return the post:
        shop
      rescue ActiveRecord::RecordInvalid => e
        # on error, return an error:
        GraphQL::ExecutionError.new(e.record.errors.to_json)
      end
    }

  end
end