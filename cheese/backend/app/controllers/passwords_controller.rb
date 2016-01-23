class PasswordsController < DeviseTokenAuth::PasswordsController
  skip_before_filter :check_format
end