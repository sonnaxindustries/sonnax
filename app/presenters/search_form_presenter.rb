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
  
  def q
    self.search_terms
  end
end