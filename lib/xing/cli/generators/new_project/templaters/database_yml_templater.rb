module Xing::CLI::Generators
  module Templaters
    class DatabaseYmlTemplater < Templater
      def template_files(arc)
        arc.copy file: "backend/config/database.yml", context: context
        arc.copy file: "backend/config/database.yml.example", context: context
        arc.copy file: "backend/config/database.yml.ci", context: context
      end
    end
  end
end
