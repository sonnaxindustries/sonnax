class Part < ActiveRecord::Base
  belongs_to :part_type
  belongs_to :product_line
  
  has_many :part_attributes, :dependent => :destroy
  
  has_many :part_assets, :dependent => :destroy
  has_many :assets, :through => :part_assets
  
  has_many :part_photos, :dependent => :destroy
  has_many :photos, :through => :part_photos, :source => :asset
  
  has_many :unit_components, :dependent => :destroy
  has_many :units, :through => :unit_components
  
  define_index do
    indexes :part_number, :sortable => true
    indexes :oem_part_number, :sortable => true
    indexes :description
    indexes :item
    indexes :notes    
    
    has created_at, updated_at, part_type_id, product_line_id
  end
  
  named_scope :recent, :conditions => ["parts.is_new_item = ?", true]
  named_scope :old, :conditions => ["parts.is_new_item = ?", false]
  named_scope :featured, :conditions => ["parts.is_featured = ?", true]
  named_scope :random_featured, :conditions => ["parts.is_featured = ?", true], :limit => 1, :order => 'RAND()'
  
  def validate
    self.errors.add(:product_line, 'Please provide a product line ID') unless self.product_line_id?
  end
  
  class << self
    def find_makes_by_filter(attrs={})
      make_id         = attrs.delete(:make)
      unit_id         = attrs.delete(:unit)
      product_line_id = attrs.delete(:product_line)
      part_id         = attrs.delete(:part)
      
      select      = "DISTINCT(m.id) AS make_id"
      from        = "parts p"
      order       = "m.name"
      joins       = []
      conditions  = []
      
      if !product_line_id.blank?
        conditions << ["pl.id = ?", product_line_id]
      end
      
      if !make_id.blank?
        conditions << ["m.id = ?", make_id]
      end
      
      if !unit_id.blank?
        conditions << ["u.id = ?", unit_id]
      end
      
      if !part_id.blank?
        conditions << ["p.id = ?", part_id]
      end
      
      joins << "LEFT JOIN product_lines pl ON pl.id = p.product_line_id"
      joins << "LEFT JOIN unit_components uc ON uc.part_id = p.id"
      joins << "LEFT JOIN units u ON u.id = uc.unit_id"
      joins << "LEFT JOIN units_makes um ON um.unit_id = u.id"
      joins << "LEFT JOIN makes m ON um.make_id = m.id"
      
      #conditions << ["p.part_number <> '' AND u.name IS NOT NULL AND m.id IS NOT NULL"]
      conditions << ["u.name IS NOT NULL AND m.id IS NOT NULL"]
      
      results = self.all(:select => select,
               :from => from,
               :joins => joins.join(' '),
               :conditions => conditions.extend(Helper::Array).to_conditions,
               :order => order)
      ids_list = results.map(&:make_id)
      makes = Make.find(ids_list, :order => 'name')
    end
    
    def find_units_by_filter(attrs={})
      make_id         = attrs.delete(:make)
      unit_id         = attrs.delete(:unit)
      product_line_id = attrs.delete(:product_line)
      part_id         = attrs.delete(:part)
      
      select      = "DISTINCT(u.id) AS unit_id"
      from        = "parts p"
      order       = "m.name"
      joins       = []
      conditions  = []
      
      if !product_line_id.blank?
        conditions << ["pl.id = ?", product_line_id]
      end
      
      if !make_id.blank?
        conditions << ["m.id = ?", make_id]
      end
      
      if !unit_id.blank?
        conditions << ["u.id = ?", unit_id]
      end
      
      if !part_id.blank?
        conditions << ["p.id = ?", part_id]
      end
      
      joins << "LEFT JOIN product_lines pl ON pl.id = p.product_line_id"
      joins << "LEFT JOIN unit_components uc ON uc.part_id = p.id"
      joins << "LEFT JOIN units u ON u.id = uc.unit_id"
      joins << "LEFT JOIN units_makes um ON um.unit_id = u.id"
      joins << "LEFT JOIN makes m ON um.make_id = m.id"
      
      #conditions << ["p.part_number <> '' AND u.name IS NOT NULL AND m.id IS NOT NULL"]
      conditions << ["u.name IS NOT NULL AND m.id IS NOT NULL"]
      
      results = self.all(:select => select,
               :from => from,
               :joins => joins.join(' '),
               :conditions => conditions.extend(Helper::Array).to_conditions,
               :order => order)
      ids_list = results.map(&:unit_id)
      units = Unit.find(ids_list, :order => 'name')
    end
    
    def find_by_filter(attrs={})
      make_id         = attrs.delete(:make)
      unit_id         = attrs.delete(:unit)
      product_line_id = attrs.delete(:product_line)
      part_id         = attrs.delete(:part)
      
      select      = "p.id, pl.name, p.part_number, p.description, p.notes, p.item, u.name as Unit, m.name AS Make, p.part_type_id, p.ref_code, p.ref_code_sort"
      from        = "parts p"
      order       = "p.part_number + 0"
      joins       = []
      conditions  = []
      
      if !product_line_id.blank?
        conditions << ["pl.id = ?", product_line_id]
      end
      
      if !make_id.blank?
        conditions << ["m.id = ?", make_id]
      end
      
      if !unit_id.blank?
        conditions << ["u.id = ?", unit_id]
      end
      
      if !part_id.blank?
        conditions << ["p.id = ?", part_id]
      end
      
      joins << "LEFT JOIN product_lines pl ON pl.id = p.product_line_id"
      joins << "LEFT JOIN unit_components uc ON uc.part_id = p.id"
      joins << "LEFT JOIN units u ON u.id = uc.unit_id"
      joins << "LEFT JOIN units_makes um ON um.unit_id = u.id"
      joins << "LEFT JOIN makes m ON um.make_id = m.id"
      
      #conditions << ["p.part_number <> '' AND u.name IS NOT NULL AND m.id IS NOT NULL"]
      conditions << ["u.name IS NOT NULL AND m.id IS NOT NULL"]
      
      self.all(:select => select,
               :from => from,
               :joins => joins.join(' '),
               :conditions => conditions.extend(Helper::Array).to_conditions,
               :order => order)

    end
  end
  
  def make
    begin
      UnitComponent.make_for_part(self)
    rescue UnitComponent::MissingUnitIds
      nil
    end
  end
  
  def make?
    !self.make.blank?
  end
  
  def before_save
    self.part_type_id = PartType.default.id unless self.part_type_id?
  end
  
  def primary_photo
    self.part_assets.photos.first
  end
  
  def primary_photo?
    !self.primary_photo.blank?
  end
end
