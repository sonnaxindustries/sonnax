class PublicationTitle < ActiveRecord::Base
  has_many :publication_categories, :class_name => 'PublicationCategoriesTitle', :dependent => :destroy
  has_many :categories, :through => :publication_categories
  
  has_attached_file :pdf
  
  define_index do
    indexes title, :sortable => true
    indexes description
    
    has created_at, updated_at
  end
  
  class << self
    def detail!(id)
      self.find_by_url_friendly!(id)
    end
  end
  
  def categories?
    self.categories.any?
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
  
  def before_save
    self.url_friendly = self.generate_url_friendly!
  end
end
