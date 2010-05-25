class PublicationKeyword < ActiveRecord::Base
  belongs_to :publication_keyword_type
  
  has_many :publication_keywords, :class_name => 'PublicationTitlesKeyword', :dependent => :destroy
  has_many :publications, :through => :publication_keywords
  
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
