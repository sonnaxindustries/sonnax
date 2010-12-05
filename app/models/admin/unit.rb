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
    set_property :delta => :delayed
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

    def options_for(attrs={})
      make_id             = attrs.delete(:make)
      product_line_id     = attrs.delete(:product_line)

      select = "DISTINCT(u.id), u.name"
      from   = "units u"
      order  = "u.name"
      conditions = []
      joins      = []

      if !make_id.blank?
        conditions << ["um.make_id = ?", make_id]
      end

      if !product_line_id.blank?
        conditions << ["u.product_line_id = ?", product_line_id]
      end

      joins << "INNER JOIN units_makes um ON u.id = um.unit_id"

      self.all(:select => select,
               :from => from,
               :joins => joins.join(' '),
               :conditions => conditions.extend(Helper::Array).to_conditions,
               :order => order)
    end
  end
end
