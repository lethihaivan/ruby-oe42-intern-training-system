class ApplicationController < ActionController::Base
  before_action :set_locale
  include SessionsHelper
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied do
    respond_to do |format|
      format.html do
        flash[:danger] = t "controllers.autorization_fail"
        redirect_to root_path
      end
      format.js{render nothing: true, status: "404"}
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password,
                   :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  private

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = if I18n.available_locales.include?(locale)
                    locale
                  else
                    I18n.default_locale
                  end
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
