class Admin::PartType < PartType
  class << self
    def options
      self.all.map { |r| [r.name, r.id] }
    end
  end
end