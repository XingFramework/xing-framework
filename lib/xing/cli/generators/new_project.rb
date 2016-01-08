require 'caliph'

module Xing::CLI::Generators
  class NewProject
    include Caliph::CommandLineDSL

    attr_accessor :target_name

    def shell
      @shell ||= Caliph.shell
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
    end
  end
end
