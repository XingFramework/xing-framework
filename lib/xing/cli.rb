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
        framework_version =
          begin
            Gem::Specification.find_by_name("xing-framework").version
          rescue Gem::LoadError
            "<developement-version>"
          end
        version "Xing CLI #{framework_version} (c) 2015 Logical Reality Design, Inc."
        stop_on SUPPORTED_VERBS
      end

      command = ARGV.shift
      case command
      when 'new'
        opts = Trollop::options do
          opt :cms, "Include content management architecture. (coming soon)"
          opt :ruby_version, "Set the ruby version used for the new project (e.g. 2.2)", :type => :string
          opt :with_gemset, "Define a gemset for use with RVM"
          stop_on ['name']
        end
        name = ARGV.shift
        Trollop::die "Please specify a project name with 'xing new <name>'" unless name
        Trollop::die "The CMS option is not yet implemented." if opts[:cms]
        if opts[:ruby_version].nil?
          opts[:ruby_version] = RUBY_VERSION
        end
        generator = Xing::CLI::Generators::NewProject.new
        generator.target_name = name
        generator.ruby_version = opts[:ruby_version]
        generator.with_gemset = opts[:with_gemset]
        generator.generate
      else
        Trollop::die "Unknown command.  Supported commands are [" + SUPPORTED_VERBS.join(" ") + "]"
      end

    end
  end
end

require 'xing/cli/generators'
