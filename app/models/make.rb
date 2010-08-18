class Make < ActiveRecord::Base
  has_many :units_makes, :dependent => :destroy
  has_many :units, :through => :units_makes, :order => 'name ASC'
  
  has_many :publication_titles_makes, :class_name => 'PublicationTitlesMake'
  has_many :publications, :through => :publication_titles_makes
  
  named_scope :list, :order => 'id ASC'
  named_scope :ordered, lambda { |order| { :order => order }}
  
  class << self  
    def allison
      self.find_by_url_friendly('allison')
    end
      
    def detail!(id)
      self.find_by_url_friendly!(id)
    end
    
    def with_publications(options={})      
      joins = []
      conditions = []
      
      joins << 'LEFT JOIN makes m ON m.id = ptm.make_id'
      
      if options[:category]
        joins << 'LEFT JOIN publication_titles pt ON pt.id = ptm.publication_title_id'
        joins << 'LEFT JOIN publication_categories_titles pct ON pct.publication_title_id = pt.id'
        conditions << ["pct.publication_category_id IN (?)", options[:category]]
      end
      
      self.all(:select => 'DISTINCT(ptm.make_id), m.*',
               :from => 'publication_titles_makes ptm',
               :joins => joins.join(' '),
               :conditions => conditions.extend(Helper::Array).to_conditions,
               :order => 'm.name ASC')
    end
  end
  
  def parts
    @parts ||= Part.find_by_filter(:make => self)
  end
  
  def units?
    self.units.any?
  end
  
  def to_param
    self.url_friendly
  end
end
