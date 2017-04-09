class UsersController < ApplicationController

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
