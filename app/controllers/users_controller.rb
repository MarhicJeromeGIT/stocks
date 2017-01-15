class UsersController < ApplicationController
  include Swagger::Blocks
  swagger_path '/pets/{id}' do
    operation :get do
      key :description, 'Returns a single pet if the user has access'
      key :operationId, 'findPetById'
      key :tags, [
        'pet'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of pet to fetch'
        key :required, true
        key :type, :integer
        key :format, :int64
      end
      response 200 do
        key :description, 'pet response'
        schema do
          key :'$ref', :Pet
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

  before_action :authenticate_user!

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def show
    @user = User.find params[:id]
    authorize @user
 
    @alerts = current_user.alerts
  end
end
