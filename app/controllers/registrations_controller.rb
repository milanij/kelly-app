class RegistrationsController < Devise::RegistrationsController
  def create
    unless params[:user][:email] == ENV['ADMIN_EMAIL_1'] ||
           params[:user][:email] == ENV['ADMIN_EMAIL_2']
      redirect_to(
        root_path,
        flash: { warning: "You are not allowed to access the admin area."}
      )
      return
    end

    super
  end
end
