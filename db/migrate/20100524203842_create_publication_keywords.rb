class CreatePublicationKeywords < ActiveRecord::Migration
  def self.up
    create_table :publication_keywords do |t|
      t.integer :publication_keyword_type_id, :null => false
      t.string :title, :null => false
      t.string :url_friendly, :null => false
      t.integer :sort_order
      t.timestamps
    end
    
    add_index :publication_keywords, :publication_keyword_type_id
    add_index :publication_keywords, :url_friendly
    add_index :publication_keywords, [:publication_keyword_type_id, :url_friendly], :unique => true, :name => 'by_keyword_type'
  end

  def self.down
    drop_table :publication_keywords
  end
end
