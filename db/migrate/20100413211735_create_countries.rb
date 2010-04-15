class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :name, :null => false, :limit => 100
      t.string :url_friendly, :null => false, :limit => 100
      t.string :code, :limit => 50
      t.string :flag_file_name
      t.integer :flag_file_size
      t.string :flag_content_type
      t.datetime :flag_updated_at
      t.timestamps
    end
    
    add_index :countries, :url_friendly, :unique => true
    add_index :countries, :code, :unique => true
  end

  def self.down
    drop_table :countries
  end
end