require 'rspec-steps'


RSpec.shared_steps "expand the menu" do
  collapsed_menu_sizes=[ :mobile, :small ]

  it "clicks on the menu (if needed)" do |example|
    if collapsed_menu_sizes.include?(Waterpig::BrowserSize.current_size(example))
      click_on('Menu')
    end
  end
end

RSpec.shared_steps "visit login" do
  it "visits root" do
    begin
      visit '/'
    rescue Object => ex
      p ex
      raise
    end
  end

  perform_steps "expand the menu"

  it "clicks on Sign In" do
    within ".session-links" do
      click_link "Sign In"
    end
  end
end

RSpec.shared_steps "sign up with" do
  it "visits root" do
    visit '/'
  end

  perform_steps "expand the menu"

  it "clicks Sign Up" do
    click_on "Sign Up"
  end

  it "fills in email and pasword" do
    fill_in "Email",           :with => @user.email
    fill_in "Email Confirmation", :with => @user.email
    fill_in "Password",        :with => @user.password
    fill_in "Password Confirmation", :with => @user.password
  end

  it "clicks Sign Up" do
    click_button "Sign Up"
  end
end

RSpec.shared_steps "sign in with" do
  perform_steps "visit login"

  it "fills in email and password" do
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
  end

  it "clicks Sign In" do
    click_button "Sign In"
  end
end
