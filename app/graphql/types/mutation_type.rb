Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createShop, function: Resolvers::CreateShop.new
end
