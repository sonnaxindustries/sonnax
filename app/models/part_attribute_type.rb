class PartAttributeType < ActiveRecord::Base
  has_many :part_attributes
  has_many :parts, :through => :part_attributes
  
  named_scope :by_key_name, lambda { |key_name| { :conditions => { :key_name => key_name }}}
  
  class << self
    def thick
      self.by_key_name('thick').first
    end
    
    def pitch
      self.by_key_name('pitch').first
    end
    
    def no_of_teeth
      self.by_key_name('no_of_teeth').first
    end
    
    def inner_diameter
      self.by_key_name('inner_diameter').first
    end
    
    def chamfer
      self.by_key_name('chamfer').first
    end
    
    def steel_driveshaft_tube_od
      self.by_key_name('steel_driveshaft_tube_od').first
    end
    
    def outer_diameter
      self.by_key_name('outer_diameter').first
    end
    
    def tube_diameter
      self.by_key_name('tube_diameter').first
    end
    
    def torque_fuse_options
      self.by_key_name('torque_fuse_options').first
    end
  end
end
