class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  protect_from_forgery with: :null_session #:exception
  skip_before_action :verify_authenticity_token
  
  before_action :set_locale
  
  rescue_from Pundit::NotAuthorizedError, with: :not_found_or_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_or_not_authorized
  
  after_action :test
  def test
    response.headers['myheader'] = 'hehehe' 
  end

  def set_locale
    I18n.locale = extract_locale_from_subdomain || I18n.default_locale

    #response.headers['Access-Control-Allow-Methods'] = 'POST, GET, UPDATE, PUT'
    #response.headers['Access-Control-Allow-Origin'] =  '*'
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
