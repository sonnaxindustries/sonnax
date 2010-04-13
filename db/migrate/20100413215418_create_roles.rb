class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name, :null => false, :limit => 100
      t.string :key_name, :null => false, :limit => 100
      t.text :description
      t.timestamps
    end
    
    add_index :roles, :key_name, :unique => true
  end

  def self.down
    drop_table :roles
  end
end