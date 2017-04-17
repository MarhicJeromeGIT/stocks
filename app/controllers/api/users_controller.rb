module Api
  class UsersController < ActionController::Base
    include Swagger::Blocks
  
    before_action :authenticate_user!
    
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token
    respond_to :json

    swagger_path '/users/me' do
      operation :get do
        key :description, 'Returns the logged-in user data'
        key :operationId, 'get_current_user'
        key :tags, [
          'user'
        ]
        parameter do
          key :name, :token
          key :in, :header
          key :description, 'Token'
          key :required, true
          key :type, :string
        end
        response 200 do
          key :description, 'user response'
          schema do
            key :'$ref', :User
          end
        end
        response :default do
          key :description, 'unexpected error'
          schema do
            key :'$ref', :ErrorModel
          end
        end
      end
    end
  
    def me
      render json: current_user
    end
  end
end
