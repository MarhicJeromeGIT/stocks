class StocksController < ApplicationController
  include Swagger::Blocks

  before_action :set_stock, only: [:show, :update, :destroy]

  # The Stock API swagger documentation
  swagger_path '/stocks' do
    operation :get do
      key :description, 'Returns the list of watchable stocks'
      key :operationId, 'findPetById'
      key :tags, [
        'stock'
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

  # GET /stocks
  def index
    @stocks = policy_scope(Stock)
    
    respond_to do |format|
      format.html
      format.json { render json: @stocks}
    end
  end

  # GET /stocks/1
  def show
    respond_to do |format|
      format.html
      format.json { render json: @stock}
    end
  end

  # POST /stocks
  def create
    @stock = Stock.new(stock_params)

    if @stock.save
      render json: @stock, status: :created, location: @stock
    else
      render json: @stock.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stocks/1
  def update
    if @stock.update(stock_params)
      render json: @stock
    else
      render json: @stock.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stocks/1
  def destroy
    @stock.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
      authorize @stock
    end

    # Only allow a trusted parameter "white list" through.
    def stock_params
      params.require(:stock).permit(:code, :codif, :name, :place)
    end
end
