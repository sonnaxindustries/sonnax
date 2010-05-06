class CreatePartAttributeTypes < ActiveRecord::Migration
  def self.up
    create_table :part_attribute_types do |t|
      t.string :name
      t.string :key_name, :null => false
      t.timestamps
    end
    
    add_index :part_attribute_types, :key_name, :unique => true
  end

  def self.down
    drop_table :part_attribute_types
  end
end
