class CreatePublicationTypes < ActiveRecord::Migration
  def self.up
    create_table :publication_types do |t|
      t.string :title, :null => false
      t.string :url_friendly, :null => false
      t.text :description
      t.integer :sort_order, :default => 1 
      t.timestamps
    end
    
    add_index :publication_types, :url_friendly, :unique => true
  end

  def self.down
    drop_table :publication_types
  end
end
