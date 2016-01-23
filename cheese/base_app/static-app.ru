$:.unshift("./backend")
require 'lib/static-app'
run XingBase::StaticApp.build("frontend/bin", ENV['XING_BACKEND_PORT'])
