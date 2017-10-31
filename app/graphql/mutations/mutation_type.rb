MUTATION_TYPE = GraphQL::ObjectType.define do
  name 'Mutation'

  field :createShop, SHOP_TYPE do
    description 'Create new shop'

    argument :input, SHOP_INPUT_TYPE

    resolve -> (_object, args, ctx) {
      begin
        data = args[:input]
        shop = ctx[:current_user].shops.create!(
            name: data[:name],
            description: data[:description],
            url: data[:url]
        )
        # on success, return the post:
        shop
      rescue ActiveRecord::RecordInvalid => e
        # on error, return an error:
        GraphQL::ExecutionError.new(e.record.errors.to_json)
      end
    }

  end

  field :updateShop, SHOP_TYPE do
    description 'Update existing shop'

    argument :shopId, types.ID do
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

    argument :file, Types::Scalars::FileType do
      description 'Image file.'
    end

    resolve -> (_object, args, ctx) {
      begin
        data = args[:input]
        puts "MUTATION ID: #{data[:shopId]}"
        shop = ctx[:current_user].shops.find_by(id: data[:shopId])
        shop.update!(
            name: data[:name],
            description: data[:description],
            url: data[:url],
            image: data[:file]
        )
        shop
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new(e.record.errors.to_json)
      end
    }
  end
end