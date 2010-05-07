class Admin::User < User
  has_many :users_roles, :class_name => 'Admin::UsersRole', :dependent => :destroy
  has_many :roles, :through => :users_roles
  
  named_scope :list, :order => 'created_at DESC'
  
  class << self
    def detail!(id)
      self.find_by_id!(id)
    end
  end
  
  def roles?
    self.roles.any?
  end
  
  def edit_users?
    self.roles? && self.roles.include?(Admin::Role.edit_users)
  end
  
  def edit_parts?
    self.roles? && self.roles.include?(Admin::Role.edit_parts)
  end
  
  def edit_makes?
    self.roles? && self.roles.include?(Admin::Role.edit_makes)
  end
  
  def edit_reference_figures?
    self.roles? && self.roles.include?(Admin::Role.edit_reference_figures)
  end
  
  def edit_publications?
    self.roles? && self.roles.include?(Admin::Role.edit_publications)
  end
  
  def edit_distributors?
    self.roles? && self.roles.include?(Admin::Role.edit_distributors)
  end
end