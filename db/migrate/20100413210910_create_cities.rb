class CreateCities < ActiveRecord::Migration
  def self.up
    create_table :cities do |t|
      t.string :name, :null => false, :limit => 100
      t.string :url_friendly, :null => false, :limit => 100
      t.timestamps
    end
    
    add_index :cities, :url_friendly, :unique => true
  end

  def self.down
    drop_table :cities
  end
end