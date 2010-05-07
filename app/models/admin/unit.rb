class Admin::Unit < Unit
  belongs_to :product_line, :class_name => 'Admin::ProductLine'
  
  define_index do
    indexes :name, :sortable => true
    indexes description
    indexes product_line.name, :as => :product_line
    
    has product_line_id
    
    has created_at, updated_at
  end
  
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