class CreatePublicationTitlesMakes < ActiveRecord::Migration
  def self.up
    create_table :publication_titles_makes do |t|
      t.integer :publication_title_id, :null => false
      t.integer :make_id, :null => false
      t.integer :sort_order
      t.timestamps
    end
    
    add_index :publication_titles_makes, :publication_title_id
    add_index :publication_titles_makes, :make_id
    add_index :publication_titles_makes, [:publication_title_id, :make_id], :unique => true, :name => 'by_make'
  end

  def self.down
    drop_table :publication_titles_makes
  end
end
