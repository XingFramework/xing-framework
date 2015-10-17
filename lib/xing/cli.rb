require 'version'

module Xing
  class CLI
    SUPPORTED_VERBS = %w{new}
    #SUPPORTED_VERBS = %w{new scaffold}
    require 'trollop'

    BANNER = <<-EOS
Xing Framework new project and code generator.  See http://github.com/XingFramework/xing-framework for platform info.

Usage:
    xing [options] <command> [command options]

Supported commands currently include: #{SUPPORTED_VERBS.join(", ")}

Examples:
    xing new fabulous   # Generates a new Xing Framework project called 'fabulous'

Global Options:
    EOS

    def handle_cli
      Trollop::options do
        banner BANNER
        version "Xing CLI #{XING_CLI_VERSION} (c) 2015 Logical Reality Design, Inc."
        stop_on SUPPORTED_VERBS
      end

      command = ARGV.shift
      case command
      when 'new'
        opts = Trollop::options do
          opt :cms, "Include content management architecture. (coming soon)"
          stop_on ['name']
        end
        name = ARGV.shift
        Trollop::die "Please specify a project name with 'xing new <name>'" unless name
        Trollop::die "The CMS option is not yet implemented." if opts[:cms]
        p "would generate project #{name}"
        #Xing::CLI::Generators::NewProject.new.generate(opts)
      else
        Trollop::die "Unknown command.  Supported commands are [" + SUPPORTED_VERBS.join(" ") + "]"
      end

    end
  end
end
