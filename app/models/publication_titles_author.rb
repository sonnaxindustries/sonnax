class PublicationTitlesAuthor < ActiveRecord::Base
  belongs_to :author, :class_name => 'PublicationAuthor', :foreign_key => 'publication_author_id'
  belongs_to :publication, :class_name => 'PublicationTitle', :foreign_key => 'publication_title_id'
end
