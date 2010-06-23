class PublicationCategory < ActiveRecord::Base
  acts_as_tree
  
  has_many :publication_titles, :class_name => 'PublicationCategoriesTitle', :dependent => :destroy
  has_many :publications, :through => :publication_titles
  
  named_scope :root_nodes, :conditions => { :parent_id => nil }, :order => 'name ASC'
  
  class << self
    def detail!(id)
      self.find_by_url_friendly!(id)
    end
  end
  
  def publications?
    self.publications.any?
  end
  
  def children?
    self.children.any?
  end
  
  def underscored_name
    self.url_friendly.underscore
  end
  
  def generate_url_friendly!
    formatted_friendly = self.name.extend(Helper::String).to_url_friendly
    return formatted_friendly if !self.class.exists?(:url_friendly => formatted_friendly)
    n = 1
    n += 1 while self.class.exists?(:url_friendly => ("%s-%s" % [formatted_friendly, n.to_s]))
    return "%s-%s" % [formatted_friendly, n.to_s]
  end
  
  def before_create
    self.url_friendly = self.generate_url_friendly!
  end
end
