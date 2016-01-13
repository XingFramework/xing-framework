$:.unshift(".")
require 'lib/static-app'
run APP_MODULE::StaticApp.build("../frontend/bin", ENV['XING_BACKEND_PORT'])
