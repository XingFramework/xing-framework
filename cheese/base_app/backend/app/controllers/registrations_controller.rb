class RegistrationsController < DeviseTokenAuth::RegistrationsController
  before_filter :configure_permitted_parameters

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u[:email] = u[:email].downcase
      u[:email_confirmation] = u[:email_confirmation].downcase
      u.permit( :email,
                :email_confirmation,
                :password,
                :password_confirmation
              )
    end
  end
end