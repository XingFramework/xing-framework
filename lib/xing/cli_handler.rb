module Xing
  class CLIHandler
    SUPPORTED_VERBS = %w{new scaffold help}
    require 'trollop'

    def handle_cli
      global_opts = Trollop::options do
        banner "Xing Framework new project generator.  See http://github.com/XingFramework/xing-framework for info."
        stop_on SUPPORTED_VERBS
      end

      command = ARGV.shift
      command_options = case command
                        when 'new'
                          Trollop::options do
                            opt :with_cms, "Include content management architecture."
                          end
                        when 'scaffold'
                          Trollop::options do
                            opt :component, "Generate an NG component-style scaffold instead of a state+controller scaffold."
                          end
                        when 'help'
                          puts "you ran the help command"
                        else
                          Trollop::die "Unknown command.  Supported commands are [" + SUPPORTED_VERBS.join(" ") + "]"
                        end
      pp :global_opts => global_opts
      pp :command => command
      pp :command_options => command_options
    end
  end
end
