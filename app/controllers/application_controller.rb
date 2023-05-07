class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  impersonates :user

  include Pagy::Backend
  include Pundit::Authorization
  include Users::TimeZone
  include Sortable

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_time_zone, if: :current_user
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
  end

  private

  def user_not_authorized(exception)
    flash[:error] = "You aren't allowed to do that"
    redirect_back fallback_location: root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :time_zone])
  end

  def set_time_zone
    Time.zone = current_user.time_zone
  end
end
