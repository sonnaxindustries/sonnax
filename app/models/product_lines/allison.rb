class ProductLines::Allison < ProductLine
  def form_presenter
    "ProductLine::%s::FormPresenter" % [interpolated_name]
  end

  def new_form_presenter(attrs={})
    attrs.reverse_merge!(:product_line => self)
    self.form_presenter.constantize.new(attrs)
  end

  def collection_presenter
    "ProductLine::%s::CollectionPresenter" % [interpolated_name]
  end

  def new_collection_presenter(attrs={})
    attrs.reverse_merge!(:product_line => self)
    self.collection_presenter.constantize.new(attrs)
  end
  
  def recent_parts
    self.parts.recent.ordered('parts.part_number ASC')
  end
  
  def search_parts(search_term)
    Part.search_by_filter(search_term, :product_line => @self)
  end

  def parts_by_filter(options={})
    options.reverse_merge!(:product_line => self) 
    @parts ||= Part.find_by_filter(options || {})
  end

private
  def interpolated_name
    self.url_friendly.underscore.classify
  end
end