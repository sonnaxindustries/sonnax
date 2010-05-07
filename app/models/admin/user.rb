class Admin::User < User
  has_many :users_roles, :class_name => 'Admin::UsersRole', :dependent => :destroy
  has_many :roles, :through => :users_roles
  
  named_scope :list, :order => 'created_at DESC'
  
  class << self
    def detail!(id)
      self.find_by_id!(id)
    end
  end
end