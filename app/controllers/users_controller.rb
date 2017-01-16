class UsersController < ApplicationController
  include Swagger::Blocks

  # The User API swagger documentation
  swagger_path '/users/{id}' do
    operation :get do
      key :description, 'Returns a single user if the user has access'
      key :operationId, 'findPetById'
      key :tags, [
        'user'
      ]
      parameter do
        key :name, :id
        key :in, :path
        key :description, 'ID of user to fetch'
        key :required, true
        key :type, :integer
        key :format, :int64
      end
      parameter do
        key :name, :uid
        key :in, :header
        key :type, :string   
      end
      parameter do
        key :name, 'access-token'
        key :in, :header
        key :type, :string
      end  
      parameter do
        key :name, 'token-type' 
        key :in, :header
        key :type, :string
        key :default, 'Bearer'
      end  
      parameter do
        key :name, 'client' 
        key :in, :header
        key :type, :string
      end
      parameter do
        key :name, 'expiry' 
        key :in, :header
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

  before_action :authenticate_user!

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def show
    puts "CURRENT USER"
      puts current_user

    @user = User.find params[:id]
    authorize @user
    
    render json: @user
  end
end
