# defines a new GraphQL type
Types::ShopType = GraphQL::ObjectType.define do
  # this type is named `Link`
  name 'Shop'

  # it has the following fields
  field :id, !types.ID
  field :name, !types.String
  field :description, !types.String
  field :url, !types.String
end