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

  before_action :authenticate_user!, except: [:facebook]

  after_action :verify_authorized, except: [:index, :facebook]
  after_action :verify_policy_scoped, only: :index

  def show
    @user = User.find params[:id]
    authorize @user
 
    @alerts = @user.alerts
    respond_to do |format|
      format.json do
        render json: @user
      end 
      format.html 
    end
  end

  def facebook
    data = request.env['omniauth.auth']&.info
    return unless data
    name = data.name
    email = data.email
    puts name
    @user = User.find_or_create_by(email: email) do |user|
      user.provider = 'facebook'
    end
    sign_in(@user)
    redirect_to root_path
  end
end
