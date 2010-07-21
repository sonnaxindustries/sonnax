class AddKeyNameToPartAssetTypes < ActiveRecord::Migration
  def self.up
    add_column :part_asset_types, :key_name, :string, :after => 'name'
    add_index :part_asset_types, :key_name, :unique => true
  end

  def self.down
    remove_column :part_asset_types, :key_name
  end
end
