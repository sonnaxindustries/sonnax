class CreateUnitsMakes < ActiveRecord::Migration
  def self.up
    create_table :units_makes do |t|
      t.integer :unit_id, :null => false
      t.integer :make_id, :null => false
      t.text :description
      t.integer :sort_order, :default => 0
      t.timestamps
    end
    
    add_index :units_makes, :unit_id
    add_index :units_makes, :make_id
    add_index :units_makes, [:unit_id, :make_id], :unique => true, :name => 'by_unit'
  end

  def self.down
    drop_table :units_makes
  end
end