$:.unshift("./backend")
require 'lib/static-app'
run LrdCms2::StaticApp.build("frontend/bin", ENV['LRD_BACKEND_PORT'])
