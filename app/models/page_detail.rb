class PageDetail
  def initialize(attrs={})
    @attributes = attrs
  end
  
  def title
    @title ||= @attributes[:title]
  end
  
  def title=(val)
    @title = val
  end
  
  def title?
    !self.title.blank?
  end
  
  def formatted_title
    "%s - Administration - Sonnax" % [self.title]
  end
  
  def default_title
    'Sonnax Administration'
  end
  
  def page_title
    if self.title? then self.formatted_title else self.default_title end
  end
  
  def body_class
    @body_class ||= @attributes[:body_class]
  end
end