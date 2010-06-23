class Make < ActiveRecord::Base
  has_many :units_makes, :dependent => :destroy
  has_many :units, :through => :units_makes
  
  has_many :publication_titles_makes, :class_name => 'PublicationTitlesMake'
  has_many :publications, :through => :publication_titles_makes
  
  named_scope :list, :order => 'id ASC'
  named_scope :ordered, lambda { |order| { :order => order }}
  
  class << self
    def detail!(id)
      self.find_by_url_friendly!(id)
    end
    
    def with_publications
      self.all(:select => 'DISTINCT(ptm.make_id), m.*',
               :from => 'publication_titles_makes ptm',
               :joins => 'LEFT JOIN makes m ON m.id = ptm.make_id',
               :order => 'm.name ASC')
    end
  end
  
  def units?
    self.units.any?
  end
  
  def to_param
    self.url_friendly
  end
end
