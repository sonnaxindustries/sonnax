class Unit < ActiveRecord::Base
  belongs_to :product_line
  belongs_to :reference_figure
  
  named_scope :list
  
  class << self
    def detail!(id)
      self.find_by_id!(id)
    end
  end
  
  def product_line?
    !self.product_line.blank?
  end
  
  def reference_figure?
    !self.reference_figure.blank?
  end
end
