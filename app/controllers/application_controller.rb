class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  
  before_action :set_locale
  
  rescue_from Pundit::NotAuthorizedError, with: :not_found_or_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_or_not_authorized

  def set_locale
    I18n.locale = extract_locale_from_subdomain || I18n.default_locale

    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS , PUT'
    response.headers['Access-Control-Allow-Origin'] =  '*'
  end
  
  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  private
  
  def not_found_or_not_authorized
    flash[:alert] = "The record does not exist or you are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
  

end
