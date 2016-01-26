require 'xing/dev-assets'

module APP_MODULE
  # The intention is to make Static::RackApp configurable via override.
  # At the moment, this is not the case - if you need to configure, replace
  # this implementation. N.b. however that the RackApp interface is slated to
  # change in the near term, and the override may need to be revisited then.
  class StaticApp < Xing::DevAssets::RackApp
    # The static app isn't always started with a Rails environment, so we can't
    # use Rails.root for this.
    def log_root
      File.expand_path("../../log", __FILE__)
    end
  end
end
