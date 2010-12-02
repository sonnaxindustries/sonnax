class Admin::ReferenceFigure < ReferenceFigure  
  #has_many :publication_categories, :class_name => 'Admin::PublicationCategoriesTitle', :dependent => :destroy
  #has_many :categories, :through => :publication_categories
  
  has_one :unit, :class_name => 'Admin::Unit'
  
  define_index do
    indexes :name, :sortable => true
    
    has created_at, updated_at
  end
  
  class << self
    def detail!(id)
      self.find_by_id!(id)
    end
    
    def options
      self.all.map { |p| [p.name, p.id] }
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
  
  def remove_avatar!
    self.avatar = nil
    self.save(false)
  end
end
