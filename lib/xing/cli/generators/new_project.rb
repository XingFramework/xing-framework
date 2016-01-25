require 'caliph'
require 'bundler'
require 'architecture/dsl'
require 'securerandom'
require 'xing/cli/templaters'
require 'xing/cli/generators/new_project/user_input'

module Xing::CLI::Generators
  class NewProject
    include Caliph::CommandLineDSL

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

      user_input.gather

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

      database_yml_templater.template
      secrets_yml_templater.template
      control_files_templater.template
      doc_files_templater.template
      code_of_conduct_templater.template

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

    def database_yml_templater
      @database_yml_templater ||= begin
        dbyml_path = File.join(target_name, "backend", "config", "database.yml")
        Xing::CLI::Templaters::DatabaseYmlTemplater.new(target_name, context, File.exist?(dbyml_path))
      end
    end

    def control_files_templater
      @control_files_templater ||= Xing::CLI::Templaters::ControlFilesTemplater.new(
        target_name, context)
    end

    def doc_files_templater
      @doc_files_templater ||= Xing::CLI::Templaters::DocFilesTemplater.new(
        target_name,
        context.merge({
          code_of_conduct_reference: (user_input.code_of_conduct ?
            "All contributors must abide by the [Code of Conduct](CODE_OF_CONDUCT.md)" : "")
        }))
    end

    def secrets_yml_templater
      @secrets_yml_templater ||= begin
        secyml_path = File.join(target_name, "backend", "config", "secrets.yml")
        Xing::CLI::Templaters::SecretsYmlTemplater.new(
          target_name,
          context.merge({
            dev_secret_key_base: SecureRandom.hex(64),
            test_secret_key_base: SecureRandom.hex(64),
          }),
          File.exist?(secyml_path)
        )
      end
    end

    def code_of_conduct_templater
      @code_of_conduct_templater ||= Xing::CLI::Templaters::CodeOfConductTemplater.new(
        target_name,
        context.merge({
          email: user_input.coc_contact_email
        }),
        !user_input.code_of_conduct)
    end

    def context
      { app_name: target_name }
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

    def user_input
      @user_input ||= UserInput.new
    end

  end
end
