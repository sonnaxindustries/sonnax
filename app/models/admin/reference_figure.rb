class Admin::ReferenceFigure < ReferenceFigure  
  define_index do
    indexes :name, :sortable => true
    
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
  
  def remove_avatar!
    self.avatar = nil
    self.save(false)
  end
end