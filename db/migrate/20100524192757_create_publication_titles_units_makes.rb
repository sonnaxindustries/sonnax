class CreatePublicationTitlesUnitsMakes < ActiveRecord::Migration
  def self.up
    create_table :publication_titles_units_makes do |t|
      t.integer :publication_title_id, :null => false
      t.integer :units_make_id, :null => false
      t.integer :sort_order
      t.timestamps
    end
    
    add_index :publication_titles_units_makes, :publication_title_id
    add_index :publication_titles_units_makes, :units_make_id
    add_index :publication_titles_units_makes, [:publication_title_id, :units_make_id], :unique => true, :name => 'by_unit_and_make'
  end

  def self.down
    drop_table :publication_titles_units_makes
  end
end
