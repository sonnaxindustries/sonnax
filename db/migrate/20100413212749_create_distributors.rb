class CreateDistributors < ActiveRecord::Migration
  def self.up
    create_table :distributors do |t|
      t.string :name, :null => false
      t.string :url_friendly, :null => false
      t.integer :postal_code_id
      t.integer :country_id, :null => false
      t.string :phone_number
      t.string :website_url
      t.timestamps
    end
    
    add_index :distributors, :url_friendly, :unique => true
    add_index :distributors, :postal_code_id
    add_index :distributors, :country_id
  end

  def self.down
    drop_table :distributors
  end
end