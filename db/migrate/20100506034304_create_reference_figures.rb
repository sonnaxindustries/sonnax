class CreateReferenceFigures < ActiveRecord::Migration
  def self.up
    create_table :reference_figures do |t|
      t.string :name, :null => false
      t.string :avatar_file_name
      t.integer :avatar_file_size
      t.string :avatar_content_type
      t.datetime :avatar_updated_at
      t.string :exploded_view_file_name
      t.integer :exploded_view_file_size
      t.string :exploded_view_content_type
      t.datetime :exploded_view_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :reference_figures
  end
end