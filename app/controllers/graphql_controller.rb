class GraphqlController < ApplicationController
  # before_action :authenticate_user!

  def execute
    context = {
      current_user: User.find_by_api_key(
        request.headers['Authorization']
      )
    }
    if context[:current_user]
      if params[:operations].present?
        operations = ensure_hash(params[:operations])
        variables = {
            "input" => operations[:variables].
                merge({"file" => params["variables.file"]})
        }
        query     = operations[:query]
      else
        variables = ensure_hash(params[:variables])
        query     = params[:query]
      end
      result = PayplusGraphServerSchema.execute(query, variables: variables, context: context)
      render json: result
    else
      render json: { errors: [{ message: 'You need provide a valid API key' }] },
             status: :bad_request
    end
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end
