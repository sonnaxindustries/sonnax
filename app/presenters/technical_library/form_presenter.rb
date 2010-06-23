class TechnicalLibrary::FormPresenter
  include ActionController::UrlWriter
  
  def initialize(attrs={})
    @attributes = attrs
  end
  
  def url
    technical_library_filter_path(self.category.url_friendly)
  end
  
  def category
    @category ||= @attributes[:category]
  end
  
  def units
    @units ||= @attributes[:units]
  end
  
  def unit_options
    self.units.map { |unit| [unit.name, unit.id] }
  end
  
  def makes
    @makes ||= @attributes[:makes]
  end
  
  def make_options
    self.makes.map { |make| [make.name, make.id] }
  end
  
  def subjects
    @subjects ||= @attributes[:subjects]
  end
  
  def subject_options
    self.subjects.map { |subject| [subject.title, subject.id] }
  end
  
  def unit
    #
  end
  
  def make
    #
  end
  
  def subject
    #
  end
end