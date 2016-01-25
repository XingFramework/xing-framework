require 'xing'
require 'xing/cli/generators/new_project/templater'

describe "xing templaters" do
  let :mock_arc do
    double("mock_arc")
  end

  let :context do
    { app_name: "cheese"}
  end

  describe Xing::CLI::Generators::Templaters::Templater
    describe "control is off" do
      let :templater do
        Xing::CLI::Generators::Templaters::Templater.new("cheese", context, false)
      end

      it "should do templating" do
        expect(templater).to receive(:architecture).with(source: File.expand_path("../../../../../default_configuration/templates/", __FILE__), destination: "cheese")
        templater.template
      end
    end

    describe "control is on" do
      let :templater do
        Xing::CLI::Generators::Templaters::Templater.new("cheese", context, true)
      end

      it "should not do templating" do
        expect(templater).to_not receive(:architecture)
      end
    end

  describe Xing::CLI::Generators::Templaters::SecretsYmlTemplater do

    let :secrets_yml_templater do
      Xing::CLI::Generators::Templaters::SecretsYmlTemplater.new("cheese", context, false)
    end

    before do
      allow(secrets_yml_templater).to receive(:architecture).and_yield(mock_arc)
    end

    it "should copy all secrets yml templates" do
      expect(mock_arc).to receive(:copy).with(file: "backend/config/secrets.yml", context: context)
      expect(mock_arc).to receive(:copy).with(file: "backend/config/secrets.yml.ci", context: context)
      expect(mock_arc).to receive(:copy).with(file: "backend/config/secrets.yml.example", context: context)
      secrets_yml_templater.template
    end
  end

  describe Xing::CLI::Generators::Templaters::DatabaseYmlTemplater do

    let :database_yml_templater do
      Xing::CLI::Generators::Templaters::DatabaseYmlTemplater.new("cheese", context, false)
    end

    before do
      allow(database_yml_templater).to receive(:architecture).and_yield(mock_arc)
    end

    it "should copy all database yml templates" do
      expect(mock_arc).to receive(:copy).with(file: "backend/config/database.yml", context: context)
      expect(mock_arc).to receive(:copy).with(file: "backend/config/database.yml.ci", context: context)
      expect(mock_arc).to receive(:copy).with(file: "backend/config/database.yml.example", context: context)
      database_yml_templater.template
    end
  end

  describe Xing::CLI::Generators::Templaters::DocFilesTemplater do

    let :doc_files_templater do
      Xing::CLI::Generators::Templaters::DocFilesTemplater.new("cheese", context, false)
    end

    before do
      allow(doc_files_templater).to receive(:architecture).and_yield(mock_arc)
    end

    it "should copy all doc files templates" do
      expect(mock_arc).to receive(:copy).with(file: "README.md", context: context)
      expect(mock_arc).to receive(:copy).with(file: "CONTRIBUTING.md")
      expect(mock_arc).to receive(:copy).with(file: "CHANGELOG.md")
      doc_files_templater.template
    end
  end

  describe Xing::CLI::Generators::Templaters::CodeOfConductTemplater do

    let :code_of_conduct_templater do
      Xing::CLI::Generators::Templaters::CodeOfConductTemplater.new("cheese", context, false)
    end

    before do
      allow(code_of_conduct_templater).to receive(:architecture).and_yield(mock_arc)
    end

    it "should copy all doc files templates" do
      expect(mock_arc).to receive(:copy).with(file: "CODE_OF_CONDUCT.md", context: context)
      code_of_conduct_templater.template
    end
  end

  describe Xing::CLI::Generators::Templaters::ControlFilesTemplater do

    let :control_files_templater do
      Xing::CLI::Generators::Templaters::ControlFilesTemplater.new("cheese", context, false)
    end

    before do
      allow(control_files_templater).to receive(:architecture).and_yield(mock_arc)
    end

    it "should copy all git control files templates" do
      expect(mock_arc).to receive(:copy).with(file: "gitignore", as: ".gitignore")
      expect(mock_arc).to receive(:copy).with(file: "backend/gitignore", as: "backend/.gitignore")
      expect(mock_arc).to receive(:copy).with(file: "frontend/gitignore", as: "frontend/.gitignore")
      expect(mock_arc).to receive(:copy).with(file: "gitattributes", as: ".gitattributes")
      expect(mock_arc).to receive(:copy).with(file: "backend/gitattributes", as: "backend/.gitattributes")
      expect(mock_arc).to receive(:copy).with(file: "frontend/gitattributes", as: "frontend/.gitattributes")
      control_files_templater.template
    end
  end
end
