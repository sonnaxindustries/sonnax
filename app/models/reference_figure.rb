class ReferenceFigure < ActiveRecord::Base
  has_attached_file :avatar,
                    :styles => { :thumbnail => '100x100', :medium => '300x300', :tiny => '30x30#' }
  has_attached_file :exploded_view
  
  named_scope :list
  
  class << self
    def detail!(id)
      self.find_by_id!(id)
    end
  end
end
