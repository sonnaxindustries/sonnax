class CreateProductLineParts < ActiveRecord::Migration
  def self.up
    create_table :product_line_parts do |t|
      t.integer :product_line_id, :null => false
      t.integer :part_id, :null => false
      t.text :summary
      t.text :description
      t.integer :sort_order
      t.boolean :is_featured, :default => false
      t.timestamps
    end
    
    add_index :product_line_parts, :product_line_id
    add_index :product_line_parts, :part_id
    add_index :product_line_parts, [:product_line_id, :part_id], :unique => true, :name => 'by_part'
    add_index :product_line_parts, :is_featured
  end

  def self.down
    drop_table :product_line_parts
  end
end
