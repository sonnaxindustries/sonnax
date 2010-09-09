class Unit < ActiveRecord::Base
  belongs_to :product_line
  belongs_to :reference_figure
  
  has_many :unit_components, :dependent => :destroy
  has_many :parts, :through => :unit_components
  
  has_many :units_makes, :dependent => :destroy
  has_many :makes, :through => :units_makes
  
  has_many :publication_titles_units, :class_name => 'PublicationTitlesUnit'
  has_many :publications, :through => :publication_titles_units
  
  named_scope :list
  
  named_scope :ordered, lambda { |o| { :order => o }}
  # named_scope :in_category, lambda { |category| 
  #   { 
  #     :select => 'DISTINCT(ptu.unit_id), units.*',
  #     :joins => 'LEFT JOIN publication_titles_units ptu ON ptu.unit_id = units.id
  #                LEFT JOIN publication_titles pt ON pt.id = ptu.publication_title_id
  #                LEFT JOIN publication_categories_titles pct ON pct.publication_title_id = pt.id',
  #     :conditions => ["pct.publication_category_id IN (?)", category]
  #   }
  # }
  
  class << self
    def detail!(id)
      self.find_by_id!(id)
    end
    
    def in_category(category)
      self.all(:select => 'DISTINCT(units.id), units.*',
                :from => 'units',
                :joins => 'LEFT JOIN units_makes um ON um.unit_id = units.id
                           LEFT JOIN makes m ON m.id = um.make_id
                           LEFT JOIN publication_titles_units ptu ON ptu.unit_id = units.id
                           LEFT JOIN publication_titles pt ON pt.id = ptu.publication_title_id
                           LEFT JOIN publication_categories_titles pct ON pct.publication_title_id = pt.id',
                :conditions => ["pct.publication_category_id IN (?)", category])
    end
    
    def with_publications(options={})
      joins = []
      conditions = []
      
      joins << 'LEFT JOIN units u ON u.id = ptu.unit_id'
      
      if options[:category]
        joins << 'LEFT JOIN publication_titles pt ON pt.id = ptu.publication_title_id'
        joins << 'LEFT JOIN publication_categories_titles pct ON pct.publication_title_id = pt.id'
        conditions << ["pct.publication_category_id IN (?)", options[:category]]
      end
      
      self.all(:select => 'DISTINCT(ptu.unit_id), u.*',
               :from => 'publication_titles_units ptu',
               :joins => joins.join(' '),
               :conditions => conditions.extend(Helper::Array).to_conditions,
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
