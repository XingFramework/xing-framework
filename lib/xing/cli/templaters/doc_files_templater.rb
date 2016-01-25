module Xing::CLI::Templaters
  class DocFilesTemplater < Templater
    def template_files(arc)
      arc.copy file: "README.md", context: context
      arc.copy file: "CONTRIBUTING.md"
      arc.copy file: "CHANGELOG.md"
    end
  end
end
