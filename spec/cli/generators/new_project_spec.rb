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

    before do
      allow(File).to receive(:expand_path)
      allow(File).to receive(:open)
      allow(File).to receive(:join)
      allow(File).to receive(:exist?)
      allow(new_project_generator.shell).to receive(:run).and_return(mock_result)
      allow(new_project_generator).to receive(:cmd)
      allow(new_project_generator).to receive(:architecture)
    end

    it "should succeed" do
      new_project_generator.generate
    end
  end
end
