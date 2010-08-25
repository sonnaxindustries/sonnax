class AddTypeToProductLines < ActiveRecord::Migration
  def self.up
    add_column :product_lines, :type, :string, :null => false
    
    add_index :product_lines, :type
  end

  def self.down
    remove_column :product_lines, :type
  end
end
