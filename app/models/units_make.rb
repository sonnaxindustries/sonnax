class UnitsMake < ActiveRecord::Base
  belongs_to :unit
  belongs_to :make
  
  has_many :publication_units_makes, :class_name => 'PublicationTitlesUnitsMake', :dependent => :destroy
  has_many :publications, :through => :publication_units_makes
  
  class << self
    def make_for_unit_ids(unit_ids)
      result = self.find(:first,
                         :include => [:make],
                         :conditions => ["units_makes.unit_id IN (?) AND units_makes.make_id > 0", unit_ids],
                         :group => 'units_makes.make_id')
      result.make
    end
  end
  
  def publications?
    self.publications.any?
  end
end