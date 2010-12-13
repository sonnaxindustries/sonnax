class Admin::Part < Part
  attr_accessor :primary_photo_src

  has_many :part_assets, :class_name => 'Admin::PartAsset', :dependent => :destroy
  has_many :assets, :through => :part_assets
  
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
    if self.new_record?
      asset_obj = Admin::Asset.create(:asset => filename)
      self.part_assets.build(:part_asset_type_id => 1, :asset => asset_obj)
    else
      if self.primary_photo?
        self.primary_photo.asset.update_attributes(:asset => filename)
      else
        asset_obj = Admin::Asset.create(:asset => filename)
        self.part_assets.create(:part_asset_type_id => 1, :asset => asset_obj)
      end
    end
  end
end
