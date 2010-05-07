class Admin::Role < Role
  has_many :users_roles, :class_name => 'Admin::UsersRole', :dependent => :destroy
  has_many :users, :through => :users_roles
  
  named_scope :list, :order => 'created_at DESC'
  named_scope :by_key_name, lambda { |name| { :conditions => { :key_name => name.to_s }}}
  
  class << self
    def edit_users
      self.by_key_name(:edit_users).first
    end
    
    def edit_parts
      self.by_key_name(:edit_parts).first
    end
    
    def edit_makes
      self.by_key_name(:edit_makes).first
    end
    
    def edit_reference_figures
      self.by_key_name(:edit_reference_figures).first
    end
    
    def edit_publications
      self.by_key_name(:edit_publications).first
    end
    
    def edit_distributors
      self.by_key_name(:edit_distributors).first
    end
  end
  
  def generate_key_name!
    formatted_friendly = self.name.extend(Helper::String).to_key_name
    return formatted_friendly if !self.class.exists?(:key_name => formatted_friendly)
    n = 1
    n += 1 while self.class.exists?(:url_friendly => ("%s_%s" % [formatted_friendly, n.to_s]))
    return "%s_%s" % [formatted_friendly, n.to_s]
  end
  
  def before_save
    self.key_name = self.generate_key_name!
  end
end