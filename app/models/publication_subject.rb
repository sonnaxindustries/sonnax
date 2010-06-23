class PublicationSubject < ActiveRecord::Base
  has_many :publication_subjects, :class_name => 'PublicationTitlesSubject', :dependent => :destroy
  has_many :publications, :through => :publication_subjects
  
  class << self
    def detail!(id)
      self.find_by_url_friendly!(id)
    end
    
    def with_publications
      self.all(:select => 'DISTINCT(pts.publication_subject_id), ps.*',
               :from => 'publication_titles_subjects pts',
               :joins => 'LEFT JOIN publication_subjects ps ON ps.id = pts.publication_subject_id',
               :order => 'ps.title ASC')
    end
  end
  
  def publications?
    self.publications.any?
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
