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

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable, :confirmable, :recoverable, :token_authenticatable

  def role
    @role    ||= Role.for(self)
  end

  validates_presence_of :email
  validates_uniqueness_of :email

  validates_presence_of :email_confirmation, :on => :create
  validates :email, confirmation: true, :on => :create
end
