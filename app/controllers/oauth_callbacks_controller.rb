class OauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    authorize_user(request.env['omniauth.auth'])
  end

  def facebook
    authorize_user(request.env['omniauth.auth'])
  end

  private

  def authorize_user(auth)
    @user = User.find_for_oauth(auth)

    if @user&.persisted?
      sign_in_and_redirect @user, event: :authintication
      set_flash_message(:notice, :success, kind: params[:action].capitalize) if is_navigational_format?
    else
      redirect_to root_path, alert: "Something went wrong"
    end
  end
end
