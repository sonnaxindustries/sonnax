require 'iconv'
require File.expand_path(File.dirname(__FILE__) + '/../helper')

module Helper::String  
  def to_url_friendly(separator = '-')
    begin
      (Iconv.new('US-ASCII//TRANSLIT', 'utf-8').iconv self).gsub(/[^\w\s\#{separator}\â€”]/,'').gsub(/[^\w]|[\_]/,' ').split.join(separator).downcase
    rescue Iconv::IllegalSequence:
      'test'
    end
  end
  
  def to_type_name
    separator = '_'
    (Iconv.new('US-ASCII//TRANSLIT', 'utf-8').iconv self).gsub(/[^\w\s\#{separator}\â€”]/,'').gsub(/[^\w]|[\_]/,' ').split.join(separator).downcase.classify
  end
  
  def to_key_name(separator = '_')
    begin
      (Iconv.new('US-ASCII//TRANSLIT', 'utf-8').iconv self).gsub(/[^\w\s\#{separator}\â€”]/,'').gsub(/[^\w]|[\_]/,' ').split.join(separator).downcase
    rescue Iconv::IllegalSequence:
      'test'
    end
  end
end