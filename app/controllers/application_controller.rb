class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  before_filter :set_locale

  def set_locale
#    available = %w{en ru uk}
#    params[:locale] ||= request.preferred_language_from(available)
#    params[:locale] ||= 'en'
    I18n.locale = params[:locale]
    I18n.locale = 'pt-br' if params[:locale] == 'br'
#    set_locale params[:locale]
  end
end

