class Admin::Distributor < Distributor
  named_scope :list, :order => 'name ASC'
  
  define_index do
    indexes :name, :sortable => true
    indexes country, :sortable => true
    indexes state, :sortable => true
    indexes city, :sortable => true
    indexes website_url
    
    has created_at, updated_at
    set_property :delta => :delayed
  end
  
  class << self
    def detail!(id)
      self.find_by_url_friendly!(id)
    end
  end
end
