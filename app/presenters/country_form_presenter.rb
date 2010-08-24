class CountryFormPresenter
  def initialize(attrs={})
    @attributes = attrs
  end
  
  def country_options
    @country_options ||= @attributes[:countries]
  end
  
  def params
    @params ||= @attributes[:params]
  end
  
  def url
    @url ||= @attributes[:url]
  end
  
  def country_code
    if self.params[:country]
      self.params[:country][:country_code]
    elsif self.params[:country_code]
      self.params[:country_code]
    else
      nil
    end
  end
  
  def selected
    @selected ||= (self.country_code || @attributes[:selected] || Distributor::DEFAULT_COUNTRY_OPTION)
  end
end