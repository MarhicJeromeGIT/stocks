module Api
  class StocksController < ActionController::Base
    include Swagger::Blocks
    
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token
    respond_to :json

    swagger_path '/stocks' do
      operation :get do
        key :description, 'Returns the list of the stocks'
        key :operationId, 'stocks'
        key :tags, [
          'stock'
        ]
        response 200 do
          key :description, 'stock response'
          schema do
            key :'$ref', :Stock
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
  
    def index
      respond_to do |format|
        format.json do
          render json: Stock.all
        end 
      end
    end
  end
end
