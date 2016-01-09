require 'caliph'

module Xing::CLI::Generators
  class NewProject
    include Caliph::CommandLineDSL

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

      with_temporary_database_yml do
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
    end

    def with_temporary_database_yml
      dbyml_path = File.join(target_name, "backend", "config", "database.yml")
      if File.exist?(dbyml_path)
        yield
      else
        begin
          File.open(dbyml_path, "w"){}
          yield
        ensure
          File.unlink(dbyml_path)
        end
      end
    end

    def write_ruby_version(*subdir)
      File.open(File.join(*([target_name] + subdir + [".ruby-version"])), "w") do |rv|
        rv.write(ruby_version)
      end
    end
  end
end
