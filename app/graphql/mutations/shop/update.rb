class Shop::Update < GraphQL::Function
  description 'Update existing shop'
  # arguments passed as "args"
  argument :id, types.ID
  argument :name, !types.String
  argument :description, !types.String
  argument :url, !types.String
  argument :image, types.String

  # return type from the mutation
  type SHOP_TYPE

  # the mutation method
  # _obj - is parent object, which in this case is nil
  # args - are the arguments passed
  # _ctx - is the GraphQL context (which would be discussed later)
  def call(_obj, args, ctx)
    shop = ctx[:current_user].shops.find_by(id: args[:id])
    shop.update!(
        name: args[:name],
        description: args[:description],
        url: args[:url],
        image: args[:image]
    )
    shop
  rescue ActiveRecord::RecordInvalid => e
    # this would catch all validation errors and translate them to GraphQL::ExecutionError
    GraphQL::ExecutionError.new(e.record.errors.to_json)
  end
end