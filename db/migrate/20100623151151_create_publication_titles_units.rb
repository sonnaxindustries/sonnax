class CreatePublicationTitlesUnits < ActiveRecord::Migration
  def self.up
    create_table :publication_titles_units do |t|
      t.integer :publication_title_id, :null => false
      t.integer :unit_id, :null => false
      t.integer :sort_order
      t.timestamps
    end
    
    add_index :publication_titles_units, :publication_title_id
    add_index :publication_titles_units, :unit_id
    add_index :publication_titles_units, [:publication_title_id, :unit_id], :unique => true, :name => 'by_unit'
  end

  def self.down
    drop_table :publication_titles_units
  end
end
