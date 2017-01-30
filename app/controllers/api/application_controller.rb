class Api::ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token #, if: -> {params[:controller].split('/')[0] == 'devise_token_auth'}
  respond_to :json
end

