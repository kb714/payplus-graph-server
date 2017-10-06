Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :shops, !types[Types::ShopType] do
    # resolve would be called in order to fetch data for that field
    resolve ->(_obj, _args, _ctx) { Shop.all }
  end

  field :shop, Types::ShopType do
    argument :id, types.ID

    resolve lambda { |_obj, args, _ctx|
      Shop.find_by(id: args['id'])
    }
  end
end
