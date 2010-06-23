class PublicationTitlesUnit < ActiveRecord::Base
  belongs_to :publication, :class_name => 'PublicationTitle', :foreign_key => 'publication_title_id'
  belongs_to :unit, :class_name => 'Unit', :foreign_key => 'unit_id'
end
