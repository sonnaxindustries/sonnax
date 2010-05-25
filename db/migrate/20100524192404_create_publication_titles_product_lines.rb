class CreatePublicationTitlesProductLines < ActiveRecord::Migration
  def self.up
    create_table :publication_titles_product_lines do |t|
      t.integer :publication_title_id, :null => false
      t.integer :product_line_id, :null => false
      t.integer :sort_order
      t.timestamps
    end
    
    add_index :publication_titles_product_lines, :publication_title_id
    add_index :publication_titles_product_lines, :product_line_id
    add_index :publication_titles_product_lines, [:publication_title_id, :product_line_id], :unique => true, :name => 'by_product_line'
  end

  def self.down
    drop_table :publication_titles_product_lines
  end
end
