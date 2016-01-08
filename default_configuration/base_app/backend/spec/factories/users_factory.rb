FactoryGirl.define do

  factory :raw_user, :class => User do
    sequence :uid do |n| "uid #{n}" end
    sequence(:email) { |nn| "user_#{nn}@example.com" }
    email_confirmation { "#{email}"}
    password 'password'
    password_confirmation 'password'

    #facebook_uid 1
    sign_in_count 20
    failed_attempts 0
    last_request_at "2014-04-14 15:20:54"
    current_sign_in_at "2014-04-14 15:20:54"
    last_sign_in_at "2014-04-14 15:20:54"
    current_sign_in_ip "10.0.0.1"
    last_sign_in_ip "10.0.0.1"
  end

  trait :confirmed do
    confirmed_at Time.now
  end

  factory :user, :parent => :raw_user, :traits => [:confirmed]

  factory :unconfirmed_user, :parent => :raw_user
  factory :confirmed_user, :parent => :user, :traits => [:confirmed]

  factory :admin_user, :parent => :user, :traits => [:confirmed] do
    role_name 'Admin'
  end

  factory :admin, :parent => :admin_user

end
