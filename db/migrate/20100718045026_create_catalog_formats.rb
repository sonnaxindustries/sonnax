class CreateCatalogFormats < ActiveRecord::Migration
  def self.up
    create_table :catalog_formats do |t|
      t.string :title, :null => false, :limit => 100
      t.string :url_friendly, :null => false, :limit => 100
      t.text :description
      t.timestamps
    end
    
    add_index :catalog_formats, :url_friendly, :unique => true
  end

  def self.down
    drop_table :catalog_formats
  end
end