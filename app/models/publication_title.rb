class PublicationTitle < ActiveRecord::Base
  has_many :publication_categories, :class_name => 'PublicationCategoriesTitle', :dependent => :destroy
  has_many :categories, :through => :publication_categories
  
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
end
