class PageDetail
  def initialize(attrs={})
    @attributes = attrs
  end
  
  def title
    @title ||= @attributes[:title]
  end
  
  def body_class
    @body_class ||= @attributes[:body_class]
  end
end