class CreateUnitComponents < ActiveRecord::Migration
  def self.up
    create_table :unit_components do |t|
      t.integer :unit_id, :null => false
      t.integer :part_id, :null => false
      t.integer :display_order, :default => 1 
      t.integer :indent, :default => 0
      t.string :code_on_reference_figure
      t.text :description
      t.text :notes
      t.string :steel_driveshaft_tube_od
      t.string :torque_fuse_options
      t.string :pts_series
      t.string :driveline_series
      t.timestamps
    end
    
    add_index :unit_components, :unit_id
    add_index :unit_components, :part_id
    add_index :unit_components, [:unit_id, :part_id], :name => 'by_part'
  end

  def self.down
    drop_table :unit_components
  end
end
