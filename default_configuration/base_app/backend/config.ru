# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

# APP_MODULE is defined in config/application.rb
run APP_MODULE::Application
