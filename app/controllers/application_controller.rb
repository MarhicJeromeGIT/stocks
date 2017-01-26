class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  #protect_from_forgery with: :null_session #:exception
  #skip_before_action :verify_authenticity_token
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: -> {params[:controller].split('/')[0] == 'devise_token_auth'}
 
 
  before_action :set_locale
 
  #rescue_from Pundit::NotAuthorizedError, with: :not_found_or_not_authorized
  #rescue_from ActiveRecord::RecordNotFound, with: :not_found_or_not_authorized
  
  def set_locale
    I18n.locale = extract_locale_from_subdomain || I18n.default_locale
  end
  
  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  private
  
  def not_found_or_not_authorized
    respond_to do |format|
      format.json {
        render json: {"erreur": "non!"}
      }
      format.html {
        flash[:alert] = "The record does not exist or you are not authorized to perform this action."
        redirect_to(request.referrer || root_path)
      }
    end
  end
  

end
