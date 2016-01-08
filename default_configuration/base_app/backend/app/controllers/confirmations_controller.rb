class ConfirmationsController < DeviseTokenAuth::ConfirmationsController
  skip_before_filter :check_format
end