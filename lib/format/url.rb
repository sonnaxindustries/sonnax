class Format::Url
  #VALID_FORMAT = /^(https?|ftp|gopher|telnet|file|notes|ms-help):((//)|(\\\\))+[\w\d:#@%/;$()~_?\+-=\\\.&]*$/
  
  def initialize(options = {})
    options.symbolize_keys!
    options.assert_valid_keys(:url)
    @attributes = options
  end
  
  class << self    
    def valid?(url)
      !url.match(self::VALID_FORMAT).blank?
    end
  end
  
  def id
    self.url
  end
  
  def url
    @attributes[:url]
  end
  
  def valid?
    self.class.valid?(self.url)
  end
end