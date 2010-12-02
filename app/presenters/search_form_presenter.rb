class SearchFormPresenter
  def initialize(attrs={})
    @attributes = attrs
  end
  
  def search_terms
    @search_terms ||= @attributes[:search_terms]
  end
  
  def url
    @url ||= @attributes[:url]
  end

  def unit_id
    @unit_id ||= @attributes[:unit_id]
  end

  def product_line_id
    @product_line_id ||= @attributes[:product_line_id]
  end
  
  def q
    self.search_terms
  end
end
