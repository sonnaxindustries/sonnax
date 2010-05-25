class CreatePublicationTitlesKeywords < ActiveRecord::Migration
  def self.up
    create_table :publication_titles_keywords do |t|
      t.integer :publication_title_id, :null => false
      t.integer :publication_keyword_id, :null => false
      t.integer :sort_order
      t.timestamps
    end
    
    add_index :publication_titles_keywords, :publication_title_id
    add_index :publication_titles_keywords, :publication_keyword_id
    add_index :publication_titles_keywords, [:publication_title_id, :publication_keyword_id], :unique => true, :name => 'by_keyword'
  end

  def self.down
    drop_table :publication_titles_keywords
  end
end
