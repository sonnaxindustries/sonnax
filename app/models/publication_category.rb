class PublicationCategory < ActiveRecord::Base
  acts_as_tree
  
  has_many :publication_titles, :class_name => 'PublicationCategoriesTitle', :dependent => :destroy
  has_many :titles, :through => :publication_titles
  
  named_scope :root_nodes, :conditions => { :parent_id => nil }, :order => 'name ASC'
  
  def titles?
    self.titles.any?
  end
  
  def children?
    self.children.any?
  end
end
