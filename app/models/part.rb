class Part < ActiveRecord::Base
  class NoSearchResults < StandardError; end
  belongs_to :part_type
  belongs_to :product_line
  
  has_many :line_items, :dependent => :destroy

  has_one :redirect, :class_name => 'PartRedirect', :foreign_key => 'old_part_id'
  has_one :redirected, :class_name => 'PartRedirect'

  def redirect?
    !self.redirect.blank?
  end

  def redirected?
    !self.redirected.blank?
  end
  
  has_many :part_attributes, :dependent => :destroy
  
  has_many :unit_components, :dependent => :destroy
  has_many :units, :through => :unit_components
  has_many :ordered_units, :through => :unit_components, :order => 'name ASC', :source => :unit
  
  define_index do
    indexes :part_number, :sortable => true
    indexes :oem_part_number, :sortable => true
    indexes :description
    indexes :item
    indexes :notes 
    
    indexes unit_components.code_on_reference_figure, :as => :reference_code, :sortable => true   
    
    where "parts.part_number <> ''"
    
    has created_at, updated_at, part_type_id, product_line_id
    set_property :delta => :delayed
  end
  
  named_scope :recent, :conditions => ["parts.is_new_item = ?", true]
  named_scope :ordered, lambda { |order| { :order => order }}
  named_scope :old, :conditions => ["parts.is_new_item = ?", false]
  named_scope :featured, :conditions => ["parts.is_featured = ?", true]
  named_scope :random_featured, :conditions => ["parts.is_featured = ?", true], :limit => 1, :order => 'RAND()'
  
  def validate
    self.errors.add(:product_line, 'Please provide a product line ID') unless self.product_line_id?
  end
  
  class << self
    def find_single!(part_number)
      part = self.find(:first, :conditions => ["(part_number = :part_number AND part_number <> '') OR (oem_part_number = :part_number AND oem_part_number <> '')", { :part_number => part_number }])
      raise ActiveRecord::RecordNotFound unless part
      part
    end
    
    def find_makes_by_filter(attrs={})
      make_id         = attrs.delete(:make)
      unit_id         = attrs.delete(:unit)
      product_line_id = attrs.delete(:product_line)
      part_id         = attrs.delete(:part)
      order_by        = attrs.delete(:order)
      
      select      = "DISTINCT(m.id) AS make_id"
      from        = "parts p"
      order       = "m.name"
      joins       = []
      conditions  = []
      
      if !order_by.blank?
        order = order_by
      end
      
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
      part_name       = attrs.delete(:part_name)
      
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
      
      if !part_name.blank?
        part_name_filter = "%s%" % [part_name]
        conditions << ["p.part_number LIKE (?)", part_name_filter]
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

   def find_by_filter_new(attrs={})
      make_id         = attrs.delete(:make)
      unit_id         = attrs.delete(:unit)
      product_line_id = attrs.delete(:product_line)
      part_id         = attrs.delete(:part)
      part_name       = attrs.delete(:part_name)
      order_by        = attrs.delete(:order)
      recent_only     = attrs.delete(:recent_only) || false

      # Had to change this, as associated units/makes were messing up
      #select      = "p.id, pl.name, p.part_number, p.oem_part_number, p.description, p.notes, p.item, p.is_new_item, u.name as Unit, uc.code_on_reference_figure, m.name AS Make, p.part_type_id, p.ref_code, p.ref_code_sort"
      #select      = "DISTINCT(p.id), pl.name, p.part_number, p.oem_part_number, p.description, p.notes, p.item, p.is_new_item, u.name as Unit, uc.code_on_reference_figure, m.name AS Make, p.part_type_id, p.ref_code, p.ref_code_sort"
      select      = "DISTINCT(m.id) AS make_id, m.name AS make_name, p.*"
      from        = "parts p"
      #order       = "CAST(uc.code_on_reference_figure AS DECIMAL(10,1)) DESC, p.part_number" #previously p.part_number + 0 to be numeric
      order       = "item ASC, m.name ASC"
      joins       = []
      conditions  = []
      
      if !order_by.blank?
        order = order_by
      end

      if recent_only
        conditions << ["p.is_new_item = ?", true]
      end
      
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
      
      if !part_name.blank?
        part_name_filter = "%s%" % [part_name]
        conditions << ["p.part_number LIKE (?)", part_name_filter]
      end
      
      joins << "LEFT JOIN product_lines pl ON pl.id = p.product_line_id"
      joins << "LEFT JOIN unit_components uc ON uc.part_id = p.id"
      joins << "LEFT JOIN units u ON u.id = uc.unit_id"
      joins << "LEFT JOIN units_makes um ON um.unit_id = u.id"
      joins << "LEFT JOIN makes m ON um.make_id = m.id"
      
      conditions << ["u.name IS NOT NULL AND m.id IS NOT NULL"]
      
      self.all(:select => select,
               :from => from,
               :joins => joins.join(' '),
               :conditions => conditions.extend(Helper::Array).to_conditions,
               :order => order)
    end
    
    def find_by_filter(attrs={})
      make_id         = attrs.delete(:make)
      unit_id         = attrs.delete(:unit)
      product_line_id = attrs.delete(:product_line)
      part_id         = attrs.delete(:part)
      part_name       = attrs.delete(:part_name)
      order_by        = attrs.delete(:order)
      
      # Had to change this, as associated units/makes were messing up
      select      = "p.id, pl.name, p.part_number, p.oem_part_number, p.description, p.notes, p.item, p.is_new_item, u.name as Unit, uc.code_on_reference_figure, m.name AS Make, p.part_type_id, p.ref_code, p.ref_code_sort"
      #select      = "DISTINCT(p.id), pl.name, p.part_number, p.oem_part_number, p.description, p.notes, p.item, p.is_new_item, u.name as Unit, uc.code_on_reference_figure, m.name AS Make, p.part_type_id, p.ref_code, p.ref_code_sort"
      from        = "parts p"
      order       = "CAST(uc.code_on_reference_figure AS DECIMAL(10,1)) DESC, p.part_number" #previously p.part_number + 0 to be numeric
      joins       = []
      conditions  = []
      
      if !order_by.blank?
        order = order_by
      end
      
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
      
      if !part_name.blank?
        part_name_filter = "%s%" % [part_name]
        conditions << ["p.part_number LIKE (?)", part_name_filter]
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
    
    def search_by_filter!(keyword, attrs={})
      make_id         = attrs.delete(:make)
      unit_id         = attrs.delete(:unit)
      product_line_id = attrs.delete(:product_line)
      part_id         = attrs.delete(:part)
      part_name       = attrs.delete(:part_name)
      order_by        = attrs.delete(:order)

      select      = "DISTINCT(p.id), p.product_line_id, pl.name, p.part_type_id, p.part_number, p.oem_part_number, p.description, p.notes, p.item, p.is_new_item, p.ref_code, p.ref_code_sort"
      from        = "parts p"
      order       = "CAST(uc.code_on_reference_figure AS DECIMAL(10,1)) DESC, p.part_number"
      joins       = []
      conditions  = []
      
      if !order_by.blank?
        order = order_by
      end
      
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

      if !part_name.blank?
        part_name_filter = "%s%" % [part_name]
        conditions << ["p.part_number LIKE (?)", part_name_filter]
      end

      joins << "LEFT JOIN product_lines pl ON pl.id = p.product_line_id"
      joins << "LEFT JOIN unit_components uc ON uc.part_id = p.id"
      joins << "LEFT JOIN units u ON u.id = uc.unit_id"
      joins << "LEFT JOIN units_makes um ON um.unit_id = u.id"
      joins << "LEFT JOIN makes m ON um.make_id = m.id"

      conditions << ["u.name IS NOT NULL AND m.id IS NOT NULL"]
      conditions << ["p.part_number LIKE ?", "#{keyword.strip}%"]


      results = self.all(:select => select,
               :from => from,
               :joins => joins.join(' '),
               :conditions => conditions.extend(Helper::Array).to_conditions,
               :order => order)
      raise Part::NoSearchResults if results.blank?
      results
    end

    def search_by_filter(keyword, attrs={})
      make_id         = attrs.delete(:make)
      unit_id         = attrs.delete(:unit)
      product_line_id = attrs.delete(:product_line)
      part_id         = attrs.delete(:part)
      part_name       = attrs.delete(:part_name)
      order_by        = attrs.delete(:order)

      select      = "DISTINCT(p.id), pl.name, p.part_type_id, p.part_number, p.oem_part_number, p.description, p.notes, p.item, p.is_new_item, p.ref_code, p.ref_code_sort"
      from        = "parts p"
      order       = "CAST(uc.code_on_reference_figure AS DECIMAL(10,1)) DESC, p.part_number"
      joins       = []
      conditions  = []
      
      if !order_by.blank?
        order = order_by
      end
      
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

      if !part_name.blank?
        part_name_filter = "%s%" % [part_name]
        conditions << ["p.part_number LIKE (?)", part_name_filter]
      end

      joins << "LEFT JOIN product_lines pl ON pl.id = p.product_line_id"
      joins << "LEFT JOIN unit_components uc ON uc.part_id = p.id"
      joins << "LEFT JOIN units u ON u.id = uc.unit_id"
      joins << "LEFT JOIN units_makes um ON um.unit_id = u.id"
      joins << "LEFT JOIN makes m ON um.make_id = m.id"

      conditions << ["u.name IS NOT NULL AND m.id IS NOT NULL"]
      conditions << ["p.part_number LIKE ?", "#{keyword}%"]


      self.all(:select => select,
               :from => from,
               :joins => joins.join(' '),
               :conditions => conditions.extend(Helper::Array).to_conditions,
               :order => order)

    end
  end

  def units_for_make(make)
    self.class.find_units_by_filter(:make => make, :part => self)
  end

  def unit_component_for_unit(unit)
    self.unit_components.find_by_unit_id(unit)
  end

  def makes
    @makes ||= Part.find_by_filter_new(:part_name => self.part_number).inject([]) { |ar,val| ar << OpenStruct.new(:make_name => val.make_name, :make_id => val.make_id); ar }
  end

  def makes?
    self.makes.any?
  end
  
  def make
    begin
      UnitComponent.make_for_part(self)
    rescue UnitComponent::MissingUnitIds
      nil
    end
  end
  
  def unit_components?
    self.unit_components.any?
  end
  
  def reference_number
    if self.respond_to?(:code_on_reference_figure)
      self.code_on_reference_figure
    else
      self.unit_components.first.code_on_reference_figure
    end
  end
  
  def make?
    !self.make.blank?
  end
  
  def before_save
    self.part_type_id = PartType.default.id unless self.part_type_id?
  end

  def pdf_path_for(type)
    type_path = "new-%s-pdfs" % [type.to_s]
    path = File.join(Rails.root, 'public', 'system', type_path)
    full_file = File.join(path, self.send(type))
    full_file
  end

  def pdf_src_for(type)
    type_path = "new-%s-pdfs" % [type.to_s]
    path = File.join('', 'system', type_path)
    full_src = File.join(path, self.send(type))
    full_src
  end

  def resources?
    self.instructions_src? || self.announcement_src? || self.tech_src? || self.vbfix_src?
  end

  def instructions_path
    pdf_path_for(:instructions)
  end

  def instructions_src
    pdf_src_for(:instructions)
  end

  def instructions_src?
    self.instructions? && File.exists?(instructions_path)
  end

  def announcement_path
    pdf_path_for(:announcement)
  end

  def announcement_src
    pdf_src_for(:announcement)
  end

  def announcement_src?
    self.announcement? && File.exists?(self.announcement_path)
  end

  def tech_path
    pdf_path_for(:tech)
  end

  def tech_src
    pdf_src_for(:tech)
  end

  def tech_src?
    self.tech? && File.exists?(self.tech_path)
  end

  def vbfix_path
    pdf_path_for(:vbfix)
  end

  def vbfix_src
    pdf_src_for(:vbfix)
  end

  def vbfix_src?
    self.vbfix? && File.exists?(self.vbfix_path)
  end

  def primary_photo_path
    path = File.join(Rails.root, 'public', 'system', 'new-part-images')
    full_file = File.join(path, self.photo)
    full_file
  end

  def primary_photo_src
    path = File.join('', 'system', 'new-part-images')
    full_src = File.join(path, self.photo)
    full_src
  end

  def primary_photo
    File.open(self.primary_photo_path) if self.primary_photo?
  end

  def primary_photo?
    return false unless self.photo?
    File.exists?(self.primary_photo_path)
  end
end
