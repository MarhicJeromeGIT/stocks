module Api
  class AlertsController
    include Swagger::Blocks

    # The Alert API swagger documentation
    swagger_path '/alerts' do
      operation :get do
        key :description, 'Returns the list of the user alerts'
        key :operationId, 'findPetById'
        key :tags, [
          'alert'
        ]
        parameter do
          key :in, :header
          key :name, 'access-token'
          key :type, :string
        end
        parameter do
          key :in, :header
          key :name, :uid
          key :type, :integer
        end
        parameter do
          key :in, :header
          key :name, :client
          key :type, :string
        end
        response 200 do
          key :description, 'list of alerts'
          schema do
            key :type, :array
            items do
              key :'$ref', :Alert
            end
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
end
