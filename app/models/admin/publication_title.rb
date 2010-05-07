class Admin::PublicationTitle < PublicationTitle
  define_index do
    indexes :title, :sortable => true
    indexes description
    
    has published_at, created_at, updated_at
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
  
  def to_param
    self.id.to_s
  end
end