class PublicationTitlesMake < ActiveRecord::Base
  belongs_to :publication, :class_name => 'PublicationTitle', :foreign_key => 'publication_title_id'
  belongs_to :make, :class_name => 'Make', :foreign_key => 'make_id'
end
