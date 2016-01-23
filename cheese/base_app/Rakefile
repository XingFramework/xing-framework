#$:.unshift './lib'

require 'bundler'

require 'xing/tasks'
Xing::Tasks::Backend.new
Xing::Tasks::Build.new
Xing::Tasks::Develop.new
Xing::Tasks::Frontend.new
Xing::Tasks::Spec.new
Xing::Tasks::Initialize.new

desc "setup database"
task :initialize => ['initialize:all']
desc "The whole shebang"
task :build => [:check_dependencies, 'build:all']

desc "Run rails server and grunt watch to start a dev environment"
task :develop => [:check_dependencies,'develop:all']

desc "Confirm that the app is in a state to run"
task :preflight => %w{check_dependencies develop:links}

desc "Run Rspec tests"
task :spec => [:check_dependencies, "spec:fast"]

task :check_dependencies => %w{backend:check_dependencies frontend:check_dependencies}
