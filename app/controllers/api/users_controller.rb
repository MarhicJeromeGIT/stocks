class Api::UsersController
  include Swagger::Blocks

  # The User API swagger documentation
  swagger_path '/api/auth/sign_in' do
    operation :post do
      key :description, "Sign in the user. Return an authentication token in the header. curl -i -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d '{ \"email\": \"alice@test.com\", \"password\": \"azerty\" }' http://52.211.249.61:3000/api/auth/sign_in"
      key :operationId, 'findPetById'
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
end
