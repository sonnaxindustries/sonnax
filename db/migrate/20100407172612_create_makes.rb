class CreateMakes < ActiveRecord::Migration
  def self.up
    create_table :makes do |t|
      t.string :name, :null => false, :limit => 150
      t.string :key_name, :null => false, :limit => 150
      t.string :url_friendly, :null => false, :limit => 150
      t.timestamps
    end
    
    add_index :makes, :key_name, :unique => true
    add_index :makes, :url_friendly, :unique => true
  end

  def self.down
    drop_table :makes
  end
end