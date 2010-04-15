class CreatePublicationTitles < ActiveRecord::Migration
  def self.up
    create_table :publication_titles do |t|
      t.string :title, :null => false
      t.string :url_friendly, :null => false
      t.text :description
      t.string :pdf_file_name
      t.integer :pdf_file_size
      t.string :pdf_content_type
      t.datetime :pdf_updated_at
      t.string :volume_number
      t.datetime :published_at
      t.timestamps
    end
    
    add_index :publication_titles, :url_friendly, :unique => true
  end

  def self.down
    drop_table :publication_titles
  end
end