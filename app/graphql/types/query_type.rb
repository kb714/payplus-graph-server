Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :shops, !types[Types::ShopType] do
    # resolve would be called in order to fetch data for that field
    resolve ->(_obj, _args, ctx) { ctx[:current_user].shops.all }
  end

  field :shop, Types::ShopType do
    argument :id, types.ID

    resolve lambda { |_obj, args, ctx|
      ctx[:current_user].shops.find_by_id(args['id'])
    }
  end
end
