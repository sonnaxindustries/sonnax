class CreatePublicationCategoriesTitles < ActiveRecord::Migration
  def self.up
    create_table :publication_categories_titles do |t|
      t.integer :publication_category_id, :null => false
      t.integer :publication_title_id, :null => false
      t.text :description
      t.integer :sort_order
    end
    
    add_index :publication_categories_titles, :publication_category_id
    add_index :publication_categories_titles, :publication_title_id
    add_index :publication_categories_titles, [:publication_category_id, :publication_title_id], :unique => true, :name => 'by_category'
  end

  def self.down
    drop_table :publication_categories_titles
  end
end