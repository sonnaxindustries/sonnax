class CreatePublicationCategories < ActiveRecord::Migration
  def self.up
    create_table :publication_categories do |t|
      t.integer :parent_id, :default => nil
      t.string :name, :null => false, :limit => 150
      t.string :url_friendly, :null => false, :limit => 150
      t.text :description
      t.timestamps
    end
    
    add_index :publication_categories, :parent_id
    add_index :publication_categories, :url_friendly, :unique => true
  end

  def self.down
    drop_table :publication_categories
  end
end