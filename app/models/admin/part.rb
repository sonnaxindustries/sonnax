class Admin::Part < Part
  class NoSearchResults < StandardError; end
  attr_accessor :primary_photo_src

  has_many :part_assets, :class_name => 'Admin::PartAsset', :dependent => :destroy
  has_many :assets, :through => :part_assets
  has_many :photo_assets, :class_name => 'Admin::PartAsset', :conditions => ["part_asset_type_id = 1"], :dependent => :destroy
  has_many :photos, :through => :photo_assets, :class_name => 'PartPhoto'

  class << self
    def search_by_product_line!(search, product_line)
      results = self.all(
        :select => "DISTINCT(p.id), p.product_line_id, p.part_type_id, p.part_number, p.oem_part_number, p.description, p.notes, p.item, p.is_new_item, p.ref_code, p.ref_code_sort",
        :from => "parts p",
        :conditions => ["p.product_line_id = ? AND p.part_number LIKE ?", product_line, "#{search}%"],
        :order => 'p.part_number'
      )

      raise Admin::Part::NoSearchResults if results.blank?
      results
    end
  end
  
  def part_assets?
    self.part_assets.any?
  end
  
  def assets?
    self.assets.any?
  end
  
  define_index do
    indexes :part_number, :sortable => true
    indexes :oem_part_number, :sortable => true
    indexes product_line.name, :as => :product_line_name
    indexes part_type.name, :as => :part_type_name
    
    has created_at, updated_at, product_line_id, part_type_id
    set_property :delta => :delayed
  end
  
  class << self
    def detail!(id)
      self.find_by_id!(id)
    end
    
    def list(params={})
      options = {
        :page => (params[:page] || 1),
        :order => 'created_at DESC'
      }

      self.paginate(options)
    end
  end

  def primary_photo_src=(val)
    @primary_photo_src = val
  end

  def after_save
    filename = @primary_photo_src
    if filename
      if self.new_record?
        asset_obj = PartPhoto.create(:asset => filename)
        self.photos.build(:asset => asset_obj)
      else
        if self.primary_photo?
          self.primary_photo.photo.update_attributes(:asset => filename)
        else
          asset_obj = PartPhoto.create(:asset => filename)
          PartAsset.create(:part_id => self.id,
                           :part_asset_type_id => 1,
                           :asset_id => asset_obj.id)
        end
      end
    end
  end
end
