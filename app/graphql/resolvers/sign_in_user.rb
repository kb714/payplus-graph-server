class Resolvers::SignInUser < GraphQL::Function
  argument :email, !Types::AuthProviderEmailInput

  # defines inline return type for the mutation
  type do
    name 'SigninPayload'

    field :token, types.String
    field :user, Types::UserType
  end

  def call(_obj, args, _ctx)
    input = args[:email]

    # basic validation
    return unless input

    user = User.find_for_authentication(email: input[:email])

    # ensures we have the correct user
    return unless user
    return unless user.valid_password?(input[:password])

    # use Ruby on Rails - ActiveSupport::MessageEncryptor, to build a token
    token = user.create_new_auth_token

    OpenStruct.new({user: user, token: token})
  end
end