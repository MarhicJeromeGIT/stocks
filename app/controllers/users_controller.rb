class UsersController < ApplicationController
  before_action :authenticate_user!

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def show
    @user = User.find params[:id]
    authorize @user
 
    @alerts = current_user.alerts
  end
end
