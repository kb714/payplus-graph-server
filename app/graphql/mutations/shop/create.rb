class Shop::Create < GraphQL::Function
  description 'Create new shop'
  # arguments passed as "args"
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
    ctx[:current_user].shops.create!(
        name: args[:name],
        description: args[:description],
        url: args[:url],
        image: args[:image]
    )
  rescue ActiveRecord::RecordInvalid => e
    GraphQL::ExecutionError.new(e.record.errors.to_json)
  end
end