require 'spec_helper'

RSpec.steps "User Sends Reset Password", :js => true, :vcr => {} do
  before :all do
    @user = FactoryGirl.create(:confirmed_user)
  end

  perform_steps "visit login"

  step "click forgot password" do
    click_on("Forgot your password?")
  end

  step "enter email address" do
    fill_in "Email", :with => @user.email
  end

  step "click send reset" do
    click_on("Send password reset instructions")
  end

  step "should have the confirmation" do
    expect(page).to have_content("Password reset email sent!")
  end

  step "should send the email" do
    email = open_email(@user.email)
    expect(email).to have_link("Change my password")
  end
end
