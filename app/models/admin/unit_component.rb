class Admin::UnitComponent < UnitComponent
  class << self
    def detail!(id)
      self.find_by_id!(id)
    end
  end
end
