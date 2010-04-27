class Make < ActiveRecord::Base
  named_scope :list, :order => 'id ASC'
  
  class << self
    def detail!(id)
      self.find_by_url_friendly!(id)
    end
  end
  
  def to_param
    self.url_friendly
  end
end
