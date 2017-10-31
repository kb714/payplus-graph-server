SHOP_INPUT_TYPE = GraphQL::InputObjectType.define do
  name "ShopInputType"
  description "Properties for creating a Shop"

  argument :name, !types.String do
    description "Name of the post."
  end

  argument :description, types.String do
    description "Description of the post."
  end

  argument :url, types.String do
    description "URL of the post."
  end
end