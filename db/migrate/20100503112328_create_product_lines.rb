class CreateProductLines < ActiveRecord::Migration
  def self.up
    create_table :product_lines do |t|
      t.string :name, :null => false
      t.string :url_friendly, :null => false
      t.boolean :is_active, :default => 1
      t.integer :sort_order, :default => 0
      t.timestamps
    end
    
    add_index :product_lines, :url_friendly, :unique => true
    add_index :product_lines, :is_active
  end

  def self.down
    drop_table :product_lines
  end
end