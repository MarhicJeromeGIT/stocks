class AlertsController < ApplicationController
  include Swagger::Blocks

  before_action :set_alert, only: [:show, :update, :destroy]

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

  before_action :authenticate_user!
  
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  # GET /alerts
  def index
    @alerts = policy_scope(Alert)
    
    respond_to do |format|
      format.html
      format.json { render json: @alerts}
    end
  end

  # GET /stocks/1
  def show
    respond_to do |format|
      format.html
      format.json { render json: @alert}
    end
  end

  # POST /stocks
  def create
    @alert = Alert.new(alert_params)
    # Add the current user if we have one :
    if user_signed_in?
      @alert.user = current_user
    end 

    if @alert.save
      render json: @alert, status: :created, location: @alert
    else
      render json: {errors: "Couldn't create the alert: " + @alert.errors.full_messages.join(',')}, :status => 422
    end
  end

  # PATCH/PUT /stocks/1
  def update
    if @alert.update(alert_params)
      render json: @alert
    else
      render json: @alert.errors, status: :unprocessable_entity
    end
  end
  
  def new
    @alert = Alert.new
  end
  
  # DELETE /stocks/1
  def destroy
    @stock.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alert
      @alert = Alert.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def alert_params
      params.require(:alert).permit(:contact, :stock_id, :target_value)
    end
end
