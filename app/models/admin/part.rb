class Admin::Part < Part
  
  define_index do
    indexes :part_number, :sortable => true
    indexes :oem_part_number, :sortable => true
    indexes product_line.name, :as => :product_line_name
    indexes part_type.name, :as => :part_type_name
    
    has created_at, updated_at, product_line_id, part_type_id
  end
  
  class << self
    def detail!(id)
      self.find_by_id!(id)
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