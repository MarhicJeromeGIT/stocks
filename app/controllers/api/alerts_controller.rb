module Api
  class AlertsController< ActionController::Base
    include Swagger::Blocks
  
    before_action :authenticate_user!
    
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token
    respond_to :json

    # The Alert API swagger documentation
    swagger_path '/alerts' do
      operation :get do
        key :description, 'Returns the current user alerts'
        key :operationId, 'alerts'
        key :tags, [
          'alert'
        ]
        parameter do
          key :name, :token
          key :in, :header
          key :description, 'Token'
          key :required, true
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
  
  
    def alerts
      render json: current_user.alerts
    end
  end
end
