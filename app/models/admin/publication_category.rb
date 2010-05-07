class Admin::PublicationCategory < PublicationCategory
  acts_as_tree
  
  has_many :publication_titles, :class_name => 'Admin::PublicationCategoriesTitle', :dependent => :destroy
  has_many :titles, :through => :publication_titles
  
  named_scope :root_nodes, :conditions => { :parent_id => nil }, :order => 'name ASC'
  named_scope :list, :order => 'created_at DESC'
  
  class << self
    def detail!(id)
      self.find_by_id!(id)
    end
    
    def options
      self.all.map { |cat| [cat.name, cat.id] }
    end
    
    def options_excluding(current)
      self.all(:conditions => ["id NOT IN (?)", current.id.to_s]).map { |cat| [cat.name, cat.id] }
    end
  end
  
  def options
    if self.new_record? then self.class.options else self.class.options_excluding(self) end
  end
  
  def parent?
    !self.parent_id?
  end
end