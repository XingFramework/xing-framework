require 'xing'
require 'xing/cli/generators/new_project'
require 'caliph/testing/mock-command-line'

#this is not a great test but we can at least add logic from here.

describe Xing::CLI::Generators::NewProject do
  describe "generate" do
    let :arc_mock do
      double("architecture mock")
    end

    let :mock_result do
      double("caliph result", :succeeded? => true, :must_succeed! => true)
    end

    let :new_project_generator do
      npg = Xing::CLI::Generators::NewProject.new
      npg.target_name = "awesome"
      npg.ruby_version = "2.2.1"
      npg
    end

    let :templater do
      double("templater")
    end

    let :user_input_mock do
      double("UserInput", :code_of_conduct => true, :coc_contact_email => "abcd@gefh.com")
    end

    before do
      allow(Xing::CLI::Generators::NewProject::UserInput).to receive(:new).and_return(user_input_mock)
      allow(user_input_mock).to receive(:gather)
      allow(File).to receive(:expand_path)
      allow(File).to receive(:open)
      allow(File).to receive(:join)
      allow(File).to receive(:exist?).and_return(false)
      allow(new_project_generator.shell).to receive(:run).and_return(mock_result)
      allow(new_project_generator).to receive(:cmd)
      allow(templater).to receive(:template)
    end

    it "should succeed and do templating" do
      expect(Xing::CLI::Templaters::SecretsYmlTemplater).to receive(:new).with(
        "awesome",
        {
          dev_secret_key_base: kind_of(String),
          test_secret_key_base: kind_of(String),
          app_name: "awesome"
        },
        false).and_return(templater)
      expect(Xing::CLI::Templaters::DatabaseYmlTemplater).to receive(:new).with(
        "awesome",
        {
          app_name: "awesome"
        },
        false).and_return(templater)
      expect(Xing::CLI::Templaters::DocFilesTemplater).to receive(:new).with(
        "awesome",
        {
          app_name: "awesome",
          code_of_conduct_reference: "All contributors must abide by the [Code of Conduct](CODE_OF_CONDUCT.md)"
        }).and_return(templater)
      expect(Xing::CLI::Templaters::CodeOfConductTemplater).to receive(:new).with(
        "awesome",
        {
          app_name: "awesome",
          email: "abcd@gefh.com"
        },
        false
        ).and_return(templater)
      expect(Xing::CLI::Templaters::ControlFilesTemplater).to receive(:new).with(
        "awesome",
        {
          app_name: "awesome"
        }).and_return(templater)
      new_project_generator.generate
    end
  end
end
