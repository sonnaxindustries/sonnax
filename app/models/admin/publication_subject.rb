class Admin::PublicationSubject < PublicationSubject
  named_scope :list, :order => 'created_at DESC'

  class << self
    def detail!(id)
      self.find_by_id!(id)
    end
  end

  def to_param
    self.id.to_s
  end
end
