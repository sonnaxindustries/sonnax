class Admin::UsersRole < UsersRole
  belongs_to :user, :class_name => 'Admin::User'
  belongs_to :role, :class_name => 'Admin::Role'
end