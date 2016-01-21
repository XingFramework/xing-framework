require 'xing/cli'

describe Xing::CLI do
  describe "handle_cli" do
    describe "new" do
      let :generator do
        double(Xing::CLI::Generators::NewProject)
      end

      subject :cli do
        Xing::CLI.new
      end

      before do
        stub_const("ARGV", ["new", "--with-gemset", "--ruby-version", "2.2.1", "cheese"])
      end

      it "should pass the right arguments to the generator and generate a project" do
        expect(Xing::CLI::Generators::NewProject).to receive(:new).and_return(generator)
        expect(generator).to receive(:target_name=).with("cheese")
        expect(generator).to receive(:ruby_version=).with("2.2.1")
        expect(generator).to receive(:with_gemset=).with(true)
        expect(generator).to receive(:generate)
        cli.handle_cli
      end
    end
  end
end
