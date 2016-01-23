require 'caliph'
require 'bundler'
require 'architecture/dsl'
require 'securerandom'

module Xing::CLI::Generators
  class NewProject
    include Caliph::CommandLineDSL
    include Architecture

    attr_accessor :target_name
    attr_accessor :ruby_version
    attr_accessor :with_gemset

    def shell
      @shell ||= Caliph.new
    end
    attr_writer :shell

    # For the moment, this is the simplest thing that can work. Zero templating
    # is done so the project will still have the default module names etc.
    def generate
      command = cmd('cp', '-a', File.expand_path('../../../../../default_configuration/base_app/', __FILE__), target_name)
      result = shell.run(command)

      unless result.succeeded?
        raise "Attempt to copy base application to #{target_name} failed!"
      end

      write_ruby_version
      write_ruby_version "frontend"
      write_ruby_version "backend"

      if with_gemset
        write_ruby_gemset
        write_ruby_gemset "frontend"
        write_ruby_gemset "backend"
      end

      write_database_yml
      write_secrets_yml

      write_git_control_files

      Bundler.with_clean_env do
        if with_gemset
          bundler = shell.run(setup_env_command &
            cmd("cd", target_name) &
            cmd("gem", "install", "bundler"))
        end

        shell.run(
          setup_env_command &
                  cmd("cd", target_name) &
                  cmd("bundle", "install")).must_succeed!

        shell.run(
          setup_env_command &
          cmd("cd", File.join(target_name, "frontend")) &
                  cmd("bundle", "install") &
                  cmd("npm", "install")).must_succeed!

        shell.run(
          setup_env_command &
          cmd("cd", File.join(target_name, "backend")) &
                  cmd("bundle", "install") &
                  cmd("rake", "xing:install:migrations")).must_succeed!
      end

    end

    def write_database_yml
      dbyml_path = File.join(target_name, "backend", "config", "database.yml")
      if !File.exist?(dbyml_path)
        with_templates do |arc|
          arc.copy file: "backend/config/database.yml", context: { app_name: target_name }
          arc.copy file: "backend/config/database.yml.example", context: { app_name: target_name }
          arc.copy file: "backend/config/database.yml.ci", context: { app_name: target_name }
        end
      end
    end

    def write_git_control_files
      with_templates do |arc|
        arc.copy file: "gitignore", as: ".gitignore"
        arc.copy file: "backend/gitignore", as:"backend/.gitignore"
        arc.copy file: "frontend/gitignore", as: "frontend/.gitignore"
        arc.copy file: "gitattributes", as: ".gitattributes"
        arc.copy file: "backend/gitattributes", as: "backend/.gitattributes"
        arc.copy file: "frontend/gitattributes", as: "frontend/.gitattributes"
      end
    end

    def write_secrets_yml
      secyml_path = File.join(target_name, "backend", "config", "secrets.yml")
      if !File.exist?(secyml_path)
        context = {
          dev_secret_key_base: SecureRandom.hex(64),
          test_secret_key_base: SecureRandom.hex(64),
          app_name: target_name
        }
        with_templates do |arc|
          arc.copy file: "backend/config/secrets.yml", context: context
          arc.copy file: "backend/config/secrets.yml.example", context: context
          arc.copy file: "backend/config/secrets.yml.ci", context: context
        end
      end
    end

    def with_templates
      architecture source: File.expand_path('../../../../../default_configuration/templates/', __FILE__) , destination: target_name  do |arc|
        yield(arc)
      end
    end

    def write_file_to(name, subdir)
      File.open(File.join(*([target_name] + subdir + [name])), "w") do |rv|
        yield(rv)
      end
    end

    def write_ruby_version(*subdir)
      write_file_to(".ruby-version", subdir) do |rv|
        rv.write(ruby_version)
      end
    end

    def write_ruby_gemset(*subdir)
      write_file_to(".ruby-gemset", subdir) do |rv|
        rv.write(target_name)
      end
    end

    def setup_env_command
      if ENV['MY_RUBY_HOME'] && ENV['MY_RUBY_HOME'].include?('rvm')
        args = [".", File.expand_path('../../../../../bin/xing-rvm-setup-env', __FILE__), ruby_version]
        args[3] = target_name if with_gemset
        cmd(*args)
      else
        # put other rb environemnt scripts here
        cmd(":")
      end
    end
  end
end
