Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  # field :signIn, function Mutations::SignIn.new
  # field :signUp, function: Resolvers::CreateUser.new
  # field :signIn, function: Resolvers::SignInUser.new
  field :createShop, function: Mutations::CreateShop.new
  field :updateShop, function: Mutations::UpdateShop.new
  field :deleteShop, function: Mutations::DeleteShop.new
end
