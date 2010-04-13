class Admin::Distributor < Distributor
  class << self
    def detail!(id)
      self.find_by_url_friendly!(id)
    end
  end
end