class CreatePartAssetTypes < ActiveRecord::Migration
  def self.up
    create_table :part_asset_types do |t|
      t.string :name, :null => false
      t.string :url_friendly, :null => false
      t.text :description
      t.timestamps
    end
    
    add_index :part_asset_types, :name
    add_index :part_asset_types, :url_friendly, :unique => true
  end

  def self.down
    drop_table :part_asset_types
  end
end
