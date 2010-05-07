class Admin::Unit < Unit
  #named_scope :list, :order => 'created_at DESC'
  belongs_to :product_line, :class_name => 'Admin::ProductLine'
  
  class << self
    def detail!(id)
      self.find_by_id!(id)
    end
    
    def per_page
      25
    end
    
    def list(params={})
      options = {
        :page => (params[:page] || 1),
        :order => 'created_at DESC'
      }

      self.paginate(options)
    end
  end
end