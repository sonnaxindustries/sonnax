class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :name, :null => false
      t.string :company, :null => false
      t.string :postal_code, :null => false
      t.string :email, :null => false
      t.string :po_number
      t.string :shipping_method, :null => false
      t.boolean :should_round_quantities, :default => true
      t.text :comments
      t.timestamps
    end
    
    add_index :orders, :postal_code
    add_index :orders, :email
    add_index :orders, :po_number
  end

  def self.down
    drop_table :orders
  end
end
