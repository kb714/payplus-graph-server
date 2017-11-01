MUTATION_TYPE = GraphQL::ObjectType.define do
  name 'Mutation'

  # Create
  field :createShop, SHOP_TYPE do
    description 'Create new shop'

    argument :name, !types.String do
      description 'Name of the post.'
    end

    argument :description, !types.String do
      description 'Description of the post.'
    end

    argument :url, !types.String do
      description 'URL of the post.'
    end

    argument :image, types.String

    resolve ->(_object, args, ctx) {
      begin
        shop = ctx[:current_user].shops.create!(
          name: args[:name],
          description: args[:description],
          url: args[:url],
          image: args[:image]
        )
        shop
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new(e.record.errors.to_json)
      end
    }

  end

  # Update
  field :updateShop, SHOP_TYPE do
    description 'Update existing shop'

    argument :id, !types.ID do
      description 'ID of Shop'
    end

    argument :name, !types.String do
      description 'Name of the post.'
    end

    argument :description, !types.String do
      description 'Description of the post.'
    end

    argument :url, !types.String do
      description 'URL of the post.'
    end

    argument :image, types.String do
      description 'Image file Base64.'
    end

    resolve ->(_object, args, ctx) {
      begin
        shop = ctx[:current_user].shops.find_by(id: args[:id])
        shop.update!(
          name: args[:name],
          description: args[:description],
          url: args[:url],
          image: args[:image]
        )
        shop
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new(e.record.errors.to_json)
      end
    }
  end

  # Delete
  field :deleteShop, SHOP_TYPE do
    description 'Delete existing Shop'

    argument :id, !types.ID

    resolve ->(_obj, args, ctx) {
      begin
        ctx[:current_user].shops.find_by_id(args[:id]).delete
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new(e.record.errors.to_json)
      end
    }
  end
end