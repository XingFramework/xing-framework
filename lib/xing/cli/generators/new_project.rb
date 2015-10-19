require 'caliph'

module Xing::CLI::Generators
  class NewProject
    include Caliph::CommandLineDSL

    BASE_PROJECT_URL = "git@github.com:XingFramework/xing-application-base.git"

    # For the moment, this is the simplest thing that can work. Zero templating is done
    # so the project will still have the default module names etc.
    def generate(options)
      shell = Caliph.new()
      command = cmd('git', 'clone', '--depth=1', '--branch=master', BASE_PROJECT_URL, options[:name])
      result = shell.run(command)

      if result.succeeded?
        remove_git_directory(options[:name], shell)
      else
        raise "Attempt to clone base git repository failed!"
      end
    end

    def remove_git_directory(name, shell)
      git_dir = File.join("#{name}", ".git")
      if File.exists?(git_dir)
        shell.run(cmd('rm -rf', git_dir))
      end
    end
  end
end
