class UnitsMake < ActiveRecord::Base
  belongs_to :unit
  belongs_to :make
  
  has_many :publication_units_makes, :class_name => 'PublicationTitlesUnitsMake', :dependent => :destroy
  has_many :publications, :through => :publication_units_makes
  
  def publications?
    self.publications.any?
  end
end