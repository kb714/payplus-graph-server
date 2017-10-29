module Types
  FileType = GraphQL::ScalarType.define do
    name
    description "ActionDispatch::Http::UploadedFile"

    coerce_input ->(action_dispatch_uploaded_file, ctx) {
      # graphql_controller.rb で渡した params["variables.file"] は
      # Railsで普通の ActionDispatch::Http::UploadedFile
      # http://api.rubyonrails.org/classes/ActionDispatch/Http/UploadedFile.html
      action_dispatch_uploaded_file
    }
  end
end