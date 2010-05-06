class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.merge_validates_length_of_login_field_options(:within => 2..50)
  end
  
  has_many :users_roles
  has_many :roles, :through => :users_roles
end