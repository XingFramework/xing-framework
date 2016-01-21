# vim: set ft=ruby :
require 'corundum/tasklibs'
require 'caliph'

module Corundum
  Corundum::register_project(__FILE__)

  core = Core.new

  core.in_namespace do
    GemspecFiles.new(core) do |files|
      files.extra_files = Rake::FileList["default_configuration/base_app/**/*"]
    end

    #Also available: 'unfinished': TODO and XXX
    ["debug", "profanity", "ableism", "racism", "gender"].each do |type|
      QuestionableContent.new(core) do |content|
        content.type = type
      end
    end
    rspec = RSpec.new(core)
    SimpleCov.new(core, rspec) do |cov|
      cov.threshold = 70
    end

    gem = GemBuilding.new(core)
    GemCutter.new(core,gem)
    Git.new(core) do |vc|
      vc.branch = "master"
    end

    task :list_files do
      core.gemspec.files.each do |file|
        puts file
      end
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

  task :cleanup => :fetch do
    require 'find'
    migrations_dir = File.join(name, "backend/db/migrate")
    shell.run('rm', '-rf', File.join(migrations_dir, "*"))
    shell.run('touch', File.join(migrations_dir, '.gitkeep'))

    Find.find(name) do |path|
      if path =~ /\.git(ignore|attributes)\z/
        dest = path.sub(/\A#{name}/, "default_configuration/templates").gsub(".","")
        shell.run("mv", "-f", path, dest)
      end
    end
  end

  desc "Update the live base files from the application base repo"
  task :refetch => [:clobber, :fetch, :cleanup]

  task :clone do
    if File.exist?(name)
      fail "Can't fetch: #{name} exists. Try app_base:refetch"
    end

    shell.run('git', 'clone', '--depth=1', '--branch=master', BASE_PROJECT_URL, name).must_succeed!
  end

  task :ungit do
    git_dir = File.join("#{name}", ".git")
    puts git_dir
    shell.run('rm', '-rf', git_dir)
  end
end
