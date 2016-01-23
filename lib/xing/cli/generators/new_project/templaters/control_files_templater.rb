module Xing::CLI::Generators
  module Templaters
    class ControlFilesTemplater < Templater
      def template_files(arc)
        arc.copy file: "gitignore", as: ".gitignore"
        arc.copy file: "backend/gitignore", as:"backend/.gitignore"
        arc.copy file: "frontend/gitignore", as: "frontend/.gitignore"
        arc.copy file: "gitattributes", as: ".gitattributes"
        arc.copy file: "backend/gitattributes", as: "backend/.gitattributes"
        arc.copy file: "frontend/gitattributes", as: "frontend/.gitattributes"
      end
    end
  end
end
