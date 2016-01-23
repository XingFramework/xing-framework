require 'spec_helper'

describe Role do
  let :admin_user      do FactoryGirl.create(:admin) end

  describe "class methods" do
    before do
      admin_user
    end

    describe "for" do
      context 'admin' do
        subject(:role){Role.for(admin_user) }
        it { is_expected.to be_a(Role::Admin) }
        it { expect(role.user).to eq(admin_user) }
      end
    end

    describe "find by scope" do

      context 'admin' do
        subject(:role){Role::Admin.users }
        it { expect(role.count).to eq(2) }
        it { expect(role.last).to eq(admin_user) }
      end
    end
  end

  describe "initialization and attachment" do

    it "should attach a AdminRole to the researcher user" do
      expect(admin_user.role).to be_a(Role::Admin)
    end

    it "should attach the user to the role" do

      # Below should be expanded when future user types are added.
      # I left it as an array of one on purpose.  -ED
      [ admin_user ].each do |user|
        expect(user.role.user).to eq(user)
      end
    end

    it "should return its role name" do
      expect(admin_user.role.role_name).to eq('Admin')
    end
  end
end
