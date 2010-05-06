class CreateUnits < ActiveRecord::Migration
  def self.up
    create_table :units do |t|
      t.integer :product_line_id, :null => false
      t.integer :reference_figure_id, :null => true, :defaul => nil
      t.string :name, :null => false
      t.text :description
      t.timestamps
    end
    
    add_index :units, :product_line_id
    add_index :units, :reference_figure_id
  end

  def self.down
    drop_table :units
  end
end