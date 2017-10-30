MUTATION_TYPE = GraphQL::ObjectType.define do
  name 'Mutation'

  field :createShop, field: ShopMutations::Create.field
end