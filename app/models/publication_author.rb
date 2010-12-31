class PublicationAuthor < ActiveRecord::Base
  has_many :publication_titles, :class_name => 'PublicationTitlesAuthor', :dependent => :destroy
  has_many :publications, :order => 'published_at DESC', :through => :publication_titles
  has_many :ordered_publications, :order => 'published_at DESC', :source => :publication, :through => :publication_titles

  class << self
    def detail!(id)
      self.find_by_id!(id, :include => [ {:ordered_publications => [:authors]}, { :publications => [:authors]}])
    end

    def options
      self.list
    end
  end

  def publications?
    self.publications.any?
  end
end
