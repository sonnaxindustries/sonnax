class PublicationTitlesUnitsMake < ActiveRecord::Base
  belongs_to :publication, :class_name => 'PublicationTitle', :foreign_key => 'publication_title_id'
  belongs_to :units_make, :class_name => 'UnitsMake', :foreign_key => 'units_make_id'
end
