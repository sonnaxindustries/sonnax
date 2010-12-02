class Admin::Unit < Unit
  belongs_to :product_line, :class_name => 'Admin::ProductLine'
  belongs_to :reference_figure, :class_name => 'Admin::ReferenceFigure'
  
  has_many :units_makes, :dependent => :destroy, :class_name => 'Admin::UnitsMake'
  has_many :makes, :through => :units_makes
  
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
        :order => 'name ASC'
      }

      self.paginate(options)
    end
  end
end
