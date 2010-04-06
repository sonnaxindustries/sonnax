class CreateRedirects < ActiveRecord::Migration
  def self.up
    create_table :redirects do |t|
      t.string :old_url, :null => false
      t.string :new_url, :null => false
      t.string :http_code, :null => false
      t.timestamps
    end
    
    add_index :redirects, :old_url, :unique => true
  end

  def self.down
    drop_table :redirects
  end
end