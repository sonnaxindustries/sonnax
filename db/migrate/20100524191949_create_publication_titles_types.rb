class CreatePublicationTitlesTypes < ActiveRecord::Migration
  def self.up
    create_table :publication_titles_types do |t|
      t.integer :publication_title_id, :null => false
      t.integer :publication_type_id, :null => false
      t.integer :sort_order
      t.timestamps
    end
    
    add_index :publication_titles_types, :publication_title_id
    add_index :publication_titles_types, :publication_type_id
    add_index :publication_titles_types, [:publication_title_id, :publication_type_id], :unique => true, :name => 'by_type'
  end

  def self.down
    drop_table :publication_titles_types
  end
end
