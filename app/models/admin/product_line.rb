class Admin::ProductLine < ProductLine
  has_many :units, :class_name => 'Admin::Unit'
  named_scope :list, :order => 'created_at DESC'
  
  class << self
    def detail!(id)
      self.find_by_id!(id)
    end
    
    def options
      self.all.map { |p| [p.name, p.id] }
    end
  end
  
  def published_status
    if self.is_active? then 'Active' else 'Inactive' end
  end
  
  def to_param
    self.id.to_s
  end
end