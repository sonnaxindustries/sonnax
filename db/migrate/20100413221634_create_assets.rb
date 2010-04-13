class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string :asset_file_name, :null => false
      t.integer :asset_file_size
      t.string :asset_content_type
      t.datetime :asset_updated_at
      t.timestamps
    end
    
    add_index :assets, :asset_content_type
  end

  def self.down
    drop_table :assets
  end
end