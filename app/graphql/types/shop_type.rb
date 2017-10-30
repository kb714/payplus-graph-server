# defines a new GraphQL type
Types::ShopType = GraphQL::ObjectType.define do
  # this type is named `Shop`
  name 'Shop'

  # it has the following fields
  field :id, !types.ID
  field :name, !types.String
  field :description, !types.String
  field :url, !types.String
  field :image, !types.String
  field :user_id, !types.ID
end