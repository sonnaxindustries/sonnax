class PartPhoto < ActiveRecord::Base
  set_table_name 'assets'
  
  has_attached_file :asset,
                    :styles => { :thumbnail => '84x63#', :medium => '460>', :large => '572>' }
  
  named_scope :photos, :conditions => ["assets.asset_content_type IN ('image/jpeg', 'image/jpg', 'image/gif', 'image/png')"]
end