class CreateLineItems < ActiveRecord::Migration
  def self.up
    create_table :line_items do |t|
      t.integer :order_id, :null => false
      t.integer :part_id, :null => false
      t.integer :quantity, :null => false
      t.text :description
      t.timestamps
    end
    
    add_index :line_items, :order_id
    add_index :line_items, :part_id
    add_index :line_items, [:order_id, :part_id], :unique => true, :name => 'by_part'
  end

  def self.down
    drop_table :line_items
  end
end
