class CreateParts < ActiveRecord::Migration
  def self.up
    create_table :parts do |t|
      t.integer :part_type_id, :null => false
      t.string :part_number
      t.string :oem_part_number
      t.string :name
      t.string :url_friendly, :null => false
      t.string :description
      t.float :price
      t.float :weight
      t.string :ref_code
      t.integer :ref_code_sort
      t.timestamps
    end
    
    add_index :parts, :part_type_id
    add_index :parts, :url_friendly, :unique => true
    add_index :parts, :part_number
    add_index :parts, :oem_part_number
  end

  def self.down
    drop_table :parts
  end
end
