class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exeption|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'application/json' }
      format.html { redirect_to root_path, alert: exeption.message }
    end
  end

  check_authorization unless: :devise_controller?
end
