class PublicationTitlesType < ActiveRecord::Base
  belongs_to :publication, :class_name => 'PublicationTitle', :foreign_key => 'publication_title_id' 
  belongs_to :publication_type
end
