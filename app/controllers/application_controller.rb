class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exeption|
    redirect_to root_path, alert: exeption.message
  end

  check_authorization unless: :devise_controller?
end
