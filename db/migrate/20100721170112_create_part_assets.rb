class CreatePartAssets < ActiveRecord::Migration
  def self.up
    create_table :part_assets do |t|
      t.integer :part_id, :null => false
      t.integer :part_asset_type_id, :null => false
      t.integer :asset_id, :null => false
      t.string :name
      t.text :description
      t.integer :sort_order
      t.timestamps
    end
    
    add_index :part_assets, :part_id
    add_index :part_assets, :part_asset_type_id
    add_index :part_assets, :asset_id
    add_index :part_assets, [:part_id, :part_asset_type_id, :asset_id], :unique => true, :name => 'by_type'
  end

  def self.down
    drop_table :part_assets
  end
end
