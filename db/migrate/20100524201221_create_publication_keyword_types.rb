class CreatePublicationKeywordTypes < ActiveRecord::Migration
  def self.up
    create_table :publication_keyword_types do |t|
      t.string :title, :null => false
      t.text :description
      t.integer :sort_order
      t.timestamps
    end
  end

  def self.down
    drop_table :publication_keyword_types
  end
end
