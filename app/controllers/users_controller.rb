class UsersController < ApplicationController
  before_action :authenticate_user!

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def show
    @user = User.find params[:id]
    authorize @user
 
    @alerts = @user.alerts
    respond_to do |format|
      format.json: {
        render json: {@user}
      }
      format.html 
  end
end
