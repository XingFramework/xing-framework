module Xing::CLI::Templaters
  class SecretsYmlTemplater < Templater
    def template_files(arc)
      arc.copy file: "backend/config/secrets.yml", context: context
      arc.copy file: "backend/config/secrets.yml.example", context: context
      arc.copy file: "backend/config/secrets.yml.ci", context: context
    end
  end
end
