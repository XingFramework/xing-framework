# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
admin = User.where(:email => 'admin@xingframework.com').first_or_create!(
  :email_confirmation => 'admin@xingframework.com',
  :password => 'password',
  :password_confirmation => 'password',
  :uid => 'admin@xingframework.com',
  :role_name => 'Admin')
admin.confirm
