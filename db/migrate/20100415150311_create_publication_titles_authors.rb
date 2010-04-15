class CreatePublicationTitlesAuthors < ActiveRecord::Migration
  def self.up
    create_table :publication_titles_authors do |t|
      t.integer :publication_title_id, :null => false
      t.integer :publication_author_id, :null => false
    end
    
    add_index :publication_titles_authors, :publication_title_id
    add_index :publication_titles_authors, :publication_author_id
    add_index :publication_titles_authors, [:publication_title_id, :publication_author_id], :unique => true, :name => 'by_author'
  end

  def self.down
    drop_table :publication_titles_authors
  end
end