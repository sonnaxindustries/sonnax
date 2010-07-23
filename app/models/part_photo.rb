class PartPhoto < ActiveRecord::Base
  set_table_name 'assets'
  
  default_scope :conditions => ["assets.asset_content_type IN ('image/jpeg', 'image/jpg', 'image/gif', 'image/png')"]
  
  belongs_to :part
  belongs_to :part_asset_type
  belongs_to :asset
  
  has_attached_file :asset,
                    :styles => { :thumbnail => '84x63#', :medium => '460>', :large => '572>' }
  
  named_scope :photos, :conditions => ["assets.asset_content_type IN ('image/jpeg', 'image/jpg', 'image/gif', 'image/png')"]
end