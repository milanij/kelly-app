class SessionsController < Devise::SessionsController
  def create
    user = User.find_by_email(params[:user][:email])

    if user && !user.admin?
      redirect_to(
        root_path,
        flash: "You must be an admin to login to this site."
      )
    end

    super
  end
end
