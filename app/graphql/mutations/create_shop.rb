class Mutations::CreateShop < GraphQL::Function
  # arguments passed as "args"
  argument :name, !types.String
  argument :description, !types.String
  argument :url, !types.String

  # return type from the mutation
  type Types::ShopType

  # the mutation method
  # _obj - is parent object, which in this case is nil
  # args - are the arguments passed
  # _ctx - is the GraphQL context (which would be discussed later)
  def call(_obj, args, ctx)
    ctx[:current_user].shops.create!(
      name: args[:name],
      description: args[:description],
      url: args[:url]
    )
  rescue ActiveRecord::RecordInvalid => e
    # this would catch all validation errors and translate them to GraphQL::ExecutionError
    GraphQL::ExecutionError.new(e.record.errors.to_json)
  end
end
