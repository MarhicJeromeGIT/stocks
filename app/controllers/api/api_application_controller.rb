module Api
  class ApiApplicationController < ActionController::Base
    include Swagger::Blocks
     
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token
    respond_to :json

    # The User API swagger documentation
    swagger_path '/sign_in_token' do
      operation :post do
        key :description, "Sign in the user. Return an authentication token in the header. curl -i -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d '{ \"email\": \"alice@test.com\", \"password\": \"azerty\" }' http://52.211.249.61:3000/api/auth/sign_in"
        key :operationId, 'sign_in_token'
        key :tags, [
          'user'
        ]
        parameter do
          key :name, :body
          key :in, :body
          key :description, 'email of the user'
          schema do
          end
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

    def sign_in
      user = User.find_by_email(params[:email])
      if user && (user.valid_password? params[:password])
        # Return a token
        token = Devise.friendly_token(32)
        user.update_attributes(warden_auth_token: token)
        render json: { token: token}
      else
        # Error message
        render json: { error: 'wrong password or id' }
      end
    end 
  end
end
