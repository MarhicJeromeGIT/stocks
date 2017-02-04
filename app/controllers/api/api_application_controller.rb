module Api
  class ApiApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token
    respond_to :json

    def sign_in
      user = User.find_by_email(params[:email])
      if user && (user.valid_password? params[:password])
        # Return a token
        token = Devise.friendly_token(32)
        user.update_attributes(warden_auth_token: token)
        render json: token
      else
        # Error message
        render json: { error: 'wrong password or id' }
      end
    end 
  end
end
