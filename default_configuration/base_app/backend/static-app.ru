$:.unshift(".")
require 'lib/static-app'
run APP_MODULE::StaticApp.build("../frontend/bin", ENV['LRD_BACKEND_PORT'])
