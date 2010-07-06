class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  before_filter :set_locale

  def set_locale
    params[:locale] ||= 'en'
    I18n.locale = params[:locale]
    I18n.locale = 'pt-br' if params[:locale] == 'br'
  end
end

