require 'spec_helper'

RSpec.steps "User Signs Up", :js => true, :vcr => {} do
  before :all do
    @user = FactoryGirl.build(:user)
  end

  perform_steps "sign up with"

  it "should have confirmation link" do
    expect(page).to have_content("confirmation link")
  end

  it "should send email" do
    expect(ActionMailer::Base.deliveries).to_not be_empty
  end

  it "should have link in email" do
    email = open_email(@user.email)
    expect(email).to have_link('Confirm my account')
  end

  step "confirm user" do
    User.last.confirm
  end

  perform_steps "sign in with"

  it "should have sign out" do
    expect(page).to have_content("Sign Out")
  end
end
