# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  login                  :string(20)       not null
#  email                  :string(255)
#  first_name             :string(60)
#  last_name              :string(60)
#  sign_in_count          :integer          default(0), not null
#  failed_attempts        :integer          default(0), not null
#  last_request_at        :datetime
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  encrypted_password     :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_token         :string(255)
#  remember_created_at    :datetime
#  unlock_token           :string(255)
#  locked_at              :datetime
#

require 'spec_helper'

describe User do
  describe "validations" do
    describe "uniqueness" do
      it "should not create two users with the same email" do
        user_1 = FactoryGirl.create(:user, :email => 'foo@foo.com')
        user_2 = FactoryGirl.build(:user, :email => 'foo@foo.com')
        expect(user_1).to be_valid
        expect(user_2).not_to be_valid
      end
    end

    describe "email confirmation" do
      it "validations confirmation on create" do
        user = FactoryGirl.build(:user, :email => 'foo@foo.com', :email_confirmation => "bar@bar.com")
        expect(user).not_to be_valid
      end

      it "can update without checking confirmation" do
        user = FactoryGirl.create(:user, :email => 'foo@foo.com')
        user.reload
        user.email = "bar@bar.com"
        expect(user).to be_valid
      end
    end
  end

end
