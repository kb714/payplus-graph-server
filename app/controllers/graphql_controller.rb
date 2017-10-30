class GraphqlController < ApplicationController
  # before_action :authenticate_user!

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    # Query context goes here, for example:
    context = {
        current_user: User.find_by_api_key(
            request.headers['Authorization']
        )
    }
    if context[:current_user]
      # result = PAYPLUS_GRAPH_SERVER_SCHEMA.execute(
      #     query,
      #     variables: variables,
      #     context: context,
      #     operation_name: operation_name
      # )
      # render json: result
      if params[:operations].present?
        # この部分で、必要となる query と variables を設定する
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
      result = PAYPLUS_GRAPH_SERVER_SCHEMA.execute(query, variables: variables, context: context)
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