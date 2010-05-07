class Admin::Distributor < Distributor
  named_scope :list, :order => 'created_at DESC'
  
  class << self
    def detail!(id)
      self.find_by_url_friendly!(id)
    end
  end
end