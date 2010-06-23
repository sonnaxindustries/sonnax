class Unit < ActiveRecord::Base
  belongs_to :product_line
  belongs_to :reference_figure
  
  has_many :units_makes, :dependent => :destroy
  has_many :makes, :through => :units_makes
  
  named_scope :list
  
  class << self
    def detail!(id)
      self.find_by_id!(id)
    end
    
    def with_publications
      self.all(:select => 'DISTINCT(ptu.unit_id), u.*',
               :from => 'publication_titles_units ptu',
               :joins => 'LEFT JOIN units u ON u.id = ptu.unit_id',
               :order => 'u.name ASC')
    end
  end
  
  def makes?
    self.makes.any?
  end
  
  def product_line?
    !self.product_line.blank?
  end
  
  def reference_figure?
    !self.reference_figure.blank?
  end
end
