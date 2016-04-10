class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :prep_4_mobile
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def verify_admin
    if !current_user.admin?
      redirect_to(
        root_url,
        flash: { error: "You must be an admin to access that page" }
      )
    end
  end

  # Mobile devices EXCLUDE iPad
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      r = /Android|webOS|iPhone|iPod|BlackBerry|IEMobile|Opera Mini/
      request.user_agent =~ r
    end
  end
  helper_method :mobile_device?

  def prep_4_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
  end

  def after_sign_in_path_for(resource)
    if current_user.admin?
      return admin_podcasts_path
    end
  end
end
