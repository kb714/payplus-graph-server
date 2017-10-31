# defines a new GraphQL type
SHOP_TYPE = GraphQL::ObjectType.define do
  # this type is named `Shop`
  name 'Shop'
  description 'Shop Type'

  # it has the following fields
  field :id, types.ID
  field :name, types.String
  field :description, types.String
  field :url, types.String
  field :image, types.String

  field :errors, types[types.String], "Reasons the object couldn't be created or updated" do
    resolve ->(obj, _args, _ctx) { obj.errors.to_h }
  end
end