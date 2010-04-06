class Redirect < ActiveRecord::Base
  class << self
    def check!(old_url)
      self.find_by_old_url!(old_url)
    end
  end
end
