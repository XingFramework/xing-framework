# vim: set ft=ruby :
require 'corundum/tasklibs'
require 'caliph'

module Corundum
  Corundum::register_project(__FILE__)

  core = Core.new

  core.in_namespace do
    GemspecFiles.new(core)

    #do |files|
      #files.extra_files = Rake::FileList["default_configuration/**/*"]
    #end

    #Also available: 'unfinished': TODO and XXX
    ["debug", "profanity", "ableism", "racism", "gender"].each do |type|
      QuestionableContent.new(core) do |content|
        content.type = type
      end
    end
    rspec = RSpec.new(core)
    SimpleCov.new(core, rspec) do |cov|
      cov.threshold = 40
    end

    gem = GemBuilding.new(core)
    GemCutter.new(core,gem)
    Git.new(core) do |vc|
      vc.branch = "master"
    end
  end
end

task :default => [:release, :publish_docs]

BASE_PROJECT_URL = "git@github.com:XingFramework/xing-application-base.git"

namespace :app_base do
  name = "default_configuration/base_app"
  shell = Caliph.new()

  task :clobber do
    shell.run("rm", "-rf", name)
  end

  task :fetch => [:clone, :ungit]
  task :refetch => [:clobber, :fetch]

  task :clone do
    if File.exist?(name)
      fail "Can't fetch: #{name} exists. Try app_base:refetch"
    end

    shell.run('git', 'clone', '--depth=1', '--branch=master', BASE_PROJECT_URL, name).must_succeed!
  end

  task :ungit do
    git_dir = File.join("#{name}", ".git")
    shell.run('rm', '-rf', git_dir)
  end
end
