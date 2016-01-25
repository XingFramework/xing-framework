require 'xing'
require 'xing/cli/generators/new_project/user_input'

describe Xing::CLI::Generators::NewProject::UserInput do
  let :highline_mock do
    double("HighLine")
  end

  let :user_input do
    Xing::CLI::Generators::NewProject::UserInput.new
  end

  before do
    expect(HighLine).to receive(:new).and_return(highline_mock)
  end

  describe "no code of conduct" do
    before do
      expect(highline_mock).to receive(:ask).with("Add a Code of Conduct? (Contributor Covenant) [Y/n] ").and_return('n')
      user_input.gather
    end

    it "should have no code of conduct" do
      expect(user_input.code_of_conduct).to eq(false)
    end
  end

  describe "with code of conduct" do
    before do
      expect(highline_mock).to receive(:ask).with("Add a Code of Conduct? (Contributor Covenant) [Y/n] ").and_return('y')
      expect(highline_mock).to receive(:ask).with("Enter a contact email for your Code of Conduct:").and_return("cheese@landofcheese.com")
      user_input.gather
    end

    it "should have a code of conduct and a contact email" do
      expect(user_input.code_of_conduct).to eq(true)
      expect(user_input.coc_contact_email).to eq("cheese@landofcheese.com")
    end
  end

end
