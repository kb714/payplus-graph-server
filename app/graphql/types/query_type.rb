QUERY_TYPE = GraphQL::ObjectType.define do
  name 'Query'
  description 'The query root of this schema'


  field :shops do
    type !types[SHOP_TYPE]
    description 'Get all Shops'
    # resolve would be called in order to fetch data for that field
    resolve ->(_obj, _args, ctx) { ctx[:current_user].shops.all }
  end

  field :shop do
    type SHOP_TYPE
    argument :id, types.ID

    resolve lambda { |_obj, args, ctx|
      ctx[:current_user].shops.find_by_id(args['id'])
    }
  end
end
