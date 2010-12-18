class ProductLines::Transmission < ProductLine
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
    #self.parts.recent.ordered('parts.part_number ASC')
    Part.find_by_filter_new(:product_line => self, :recent_only => true, :order => 'p.part_number ASC')
  end
  
  def search_parts(keyword)
    Part.find(:all,
              :select => 'DISTINCT(m.id) AS make_id, m.name AS make_name, p.*',
              :from => 'parts p',
              :joins => "LEFT JOIN product_lines pl ON pl.id = p.product_line_id
                         LEFT JOIN unit_components uc ON uc.part_id = p.id
                         LEFT JOIN units u ON u.id = uc.unit_id
                         LEFT JOIN units_makes um ON um.unit_id = uc.unit_id
                         LEFT JOIN makes m ON m.id = um.make_id",
              :conditions => ["p.part_number LIKE ? AND u.name IS NOT NULL AND m.id IS NOT NULL AND p.product_line_id = ?", "#{keyword}%", self],
              :order => 'item ASC, m.name ASC')
    #Part.search_by_filter(search_term, :product_line => self)
  end

  def parts_by_filter(options={})
    options.reverse_merge!(:product_line => self) 
    @parts ||= Part.find_by_filter_new(options || {})
  end

private
  def interpolated_name
    self.url_friendly.underscore.classify
  end
end
