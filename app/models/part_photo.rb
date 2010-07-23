class PartPhoto < ActiveRecord::Base
  set_table_name 'assets'
  
  default_scope :conditions => ["assets.asset_content_type IN ('image/jpeg', 'image/jpg', 'image/gif', 'image/png')"]
  
  has_many :part_assets, :foreign_key => 'asset_id'
  has_many :parts, :through => :part_assets
  
  has_attached_file :asset,
                    :styles => { :thumbnail => '75x75#', :medium => '300>', :large => '572>' },
                    :default_url => '/system/assets/:style/missing.gif'
  
  named_scope :photos, :conditions => ["assets.asset_content_type IN ('image/jpeg', 'image/jpg', 'image/gif', 'image/png')"]
  
  def parts?
    self.parts.any?
  end
end