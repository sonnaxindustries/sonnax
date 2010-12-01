class PublicationSubject < ActiveRecord::Base
  has_many :publication_subjects, :class_name => 'PublicationTitlesSubject', :dependent => :destroy
  has_many :publications, :through => :publication_subjects
  
  class << self
    def detail!(id)
      self.find_by_url_friendly!(id)
    end
    
    def with_publications(options={})
      joins = []
      conditions = []
      
      joins << 'LEFT JOIN publication_subjects ps ON ps.id = pts.publication_subject_id'
      
      if options[:category]
        joins << 'LEFT JOIN publication_titles pt ON pt.id = pts.publication_title_id'
        joins << 'LEFT JOIN publication_categories_titles pct ON pct.publication_title_id = pt.id'
        conditions << ["pct.publication_category_id IN (?)", options[:category]]
      end
      
      self.all(:select => 'DISTINCT(pts.publication_subject_id), ps.*',
               :from => 'publication_titles_subjects pts',
               :joins => joins.join(' '),
               :conditions => conditions.extend(Helper::Array).to_conditions,
               :order => 'ps.title ASC')
    end
  end
  
  def publications?
    self.publications.any?
  end

  def categories
    self.class.find(:all, 
                    :select => 'DISTINCT(pct.publication_category_id), pc.name',
                    :from => 'publication_titles_subjects pts',
                    :joins => "LEFT JOIN publication_titles pt ON pt.id = pts.publication_title_id
                               LEFT JOIN publication_categories_titles pct ON pct.publication_title_id = pt.id
                               LEFT JOIN publication_categories pc ON pc.id = pct.publication_category_id",
                    :conditions => ["pts.publication_subject_id = ?", self.id])
  end
  
  def to_param
    self.url_friendly
  end
  
  def generate_url_friendly!
    formatted_friendly = self.title.extend(Helper::String).to_url_friendly
    return formatted_friendly if !self.class.exists?(:url_friendly => formatted_friendly)
    n = 1
    n += 1 while self.class.exists?(:url_friendly => ("%s-%s" % [formatted_friendly, n.to_s]))
    return "%s-%s" % [formatted_friendly, n.to_s]
  end
  
  def before_create
    self.url_friendly = self.generate_url_friendly!
  end
end
