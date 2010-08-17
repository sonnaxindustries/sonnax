class CreateCatalogRequests < ActiveRecord::Migration
  def self.up
    create_table :catalog_requests do |t|
      t.string :name, :null => false
      t.string :company, :null => false
      t.string :type_of_business, :null => false
      t.string :address, :null => false
      t.string :city, :null => false
      t.string :state, :null => false
      t.string :postal_code, :null => false
      t.string :country, :null => false
      t.string :phone_number, :null => false
      t.string :email_address, :null => false
      t.timestamps
    end
    
    add_index :catalog_requests, :name
    add_index :catalog_requests, :email_address
    add_index :catalog_requests, :postal_code
  end

  def self.down
    drop_table :catalog_requests
  end
end
