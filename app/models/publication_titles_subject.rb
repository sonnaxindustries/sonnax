class PublicationTitlesSubject < ActiveRecord::Base
  belongs_to :publication, :class_name => 'PublicationTitle', :foreign_key => 'publication_title_id'
  belongs_to :subject, :class_name => 'PublicationSubject', :foreign_key => 'publication_subject_id'
end
