module DeviseExtraTestHelper

  def current_user(stubs = {})
    return nil if current_user_session.nil?
    current_user_session.user
  end

  alias :current_person :current_user

  def warden #:nodoc:
    @warden ||= begin
      manager = Warden::Manager.new(nil) do |config|
        config.merge! Devise.warden_config
      end
      @request.env['warden'] = Warden::Proxy.new(@request.env, manager)
    end
  end

  def sign_in(user)
    warden
    auth_header = user.create_new_auth_token
    auth_header.each_pair do |k, v|
      request.headers[k] = v
    end
    request.env['devise.mapping'] = :user
  end

  def sign_out(user)
  end

  def current_user_session(stubs = {}, user_stubs = {})
    @current_user_session = UserSession.find
    # else
    #   @current_user_session ||= mock_model(UserSession, {:person => current_user(user_stubs)}.merge(stubs))
    # end
  end

  def login_as(user)
    user = case user
           when Symbol
            Factory.create(user)
           when String
            FactoryGirl.create(user.to_sym)
           when User
             user
           else
             raise "Could not figure out login_as mapping for #{user.inspect}"
           end
    sign_in user
    user
  end
  alias authenticate login_as

  def logout
    sign_out :user
  end

  def verify_authorization_successful
    expect(response).not_to redirect_to(login_path)
  end

  def verify_authorization_unsuccessful
    expect(response).to redirect_to(login_path)
  end

end

module RSpec::Rails::ControllerExampleGroup
  include DeviseExtraTestHelper
end

module RSpec::Rails::ViewExampleGroup
  include DeviseExtraTestHelper
end

module RSpec::Rails::HelperExampleGroup
  include DeviseExtraTestHelper
end
