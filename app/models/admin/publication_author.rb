class Admin::PublicationAuthor < PublicationAuthor
  named_scope :list, :order => 'last_name DESC'

  class << self
    def detail!(id)
      self.find_by_id!(id)
    end
  end
end
