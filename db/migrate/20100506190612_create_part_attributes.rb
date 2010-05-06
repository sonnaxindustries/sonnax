class CreatePartAttributes < ActiveRecord::Migration
  def self.up
    create_table :part_attributes do |t|
      t.integer :part_id, :null => false
      t.integer :part_attribute_type_id, :null => false
      t.string :attr_value
      t.timestamps
    end
    
    add_index :part_attributes, :part_id
    add_index :part_attributes, :part_attribute_type_id
  end

  def self.down
    drop_table :part_attributes
  end
end
