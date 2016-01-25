module Xing::CLI::Generators
  module Templaters
    class CodeOfConductTemplater < Templater
      def template_files(arc)
        arc.copy file: "CODE_OF_CONDUCT.md", context: context
      end
    end
  end
end
