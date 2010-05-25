class PublicationTitlesKeyword < ActiveRecord::Base
  belongs_to :publication, :class_name => 'PublicationTitle', :foreign_key => 'publication_title_id'
  belongs_to :keyword, :class_name => 'PublicationKeyword', :foreign_key => 'publication_keyword_id'
end
