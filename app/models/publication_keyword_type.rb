class PublicationKeywordType < ActiveRecord::Base
  has_many :keywords, :class_name => 'PublicationKeyword'
  
  def keywords?
    self.keywords.any?
  end
end
