require 'caliph'
require 'bundler'
require 'architecture/dsl'

module Xing::CLI::Generators
  class NewProject
    include Caliph::CommandLineDSL
    include Architecture

    attr_accessor :target_name
    attr_accessor :ruby_version

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

      write_database_yml
      write_secrets_yml

      Bundler.with_clean_env do
        shell.run(cmd("cd", target_name) &
                  cmd("bundle", "install")).must_succeed!

        shell.run(cmd("cd", File.join(target_name, "frontend")) &
                  cmd("bundle", "install") &
                  cmd("npm", "install")).must_succeed!

        shell.run(cmd("cd", File.join(target_name, "backend")) &
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

  end
end
