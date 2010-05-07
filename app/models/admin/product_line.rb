class Admin::ProductLine < ProductLine
  named_scope :list, :order => 'created_at DESC'
  
  class << self
    def detail!(id)
      self.find_by_id!(id)
    end
  end
  
  def published_status
    if self.is_active? then 'Active' else 'Inactive' end
  end
  
  def to_param
    self.id.to_s
  end
end