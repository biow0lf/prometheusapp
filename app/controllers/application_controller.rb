class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_gettext_locale
  before_filter :fix_params_locale

  def fix_params_locale
    params[:locale] ||= 'en'
  end

#  layout 'application'
#  before_filter :set_locale
#
#  def set_locale
#    params[:locale] ||= 'en'
#    I18n.locale = params[:locale]
#    I18n.locale = 'pt-br' if params[:locale] == 'br'
#  end
end

