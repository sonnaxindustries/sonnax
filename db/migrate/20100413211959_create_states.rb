class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      t.string :name, :null => false, :limit => 100
      t.string :url_friendly, :null => false, :limit => 100
      t.string :code, :limit => 50
      t.timestamps
    end
    
    add_index :states, :url_friendly, :unique => true
    add_index :states, :code
  end

  def self.down
    drop_table :states
  end
end