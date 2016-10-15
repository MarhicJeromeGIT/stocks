class AlertsController < ApplicationController
  before_action :set_alert, only: [:show, :update, :destroy]

  # GET /stocks
  def index
    @alerts = Stock.all
    
    respond_to do |format|
      format.html
      format.json { render json: @alerts}
    end
  end

  # GET /stocks/1
  def show
    @alert = Alert.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @alert}
    end
  end

  # POST /stocks
  def create
    @alert = Alert.new(alert_params)

    if @alert.save
      render json: @alert, status: :created, location: @alert
    else
      render json: {errors: @alert.errors.full_messages.join(',')}, :status => 422
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
      alert = Alert.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def alert_params
      params.require(:alert).permit(:contact, :stock_id, :target_value)
    end
end
