class PublicationAuthor < ActiveRecord::Base
  has_many :publication_authors, :class_name => 'PublicationTitlesAuthor', :dependent => :destroy
  has_many :publications, :through => :publication_authors
  
  class << self
    def detail!(id)
      self.find_by_id!(id)
    end
  end
  
  def publications?
    self.publications.any?
  end
end
