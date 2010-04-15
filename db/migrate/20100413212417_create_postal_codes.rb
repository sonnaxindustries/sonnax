class CreatePostalCodes < ActiveRecord::Migration
  def self.up
    create_table :postal_codes do |t|
      t.string :code, :null => false, :limit => 25
      t.integer :city_id, :null => false
      t.integer :state_id, :null => false
      t.integer :postal_code_type_id, :null => false
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
    
    add_index :postal_codes, :code, :unique => true
    add_index :postal_codes, :city_id
    add_index :postal_codes, :state_id
    add_index :postal_codes, [:code, :city_id, :state_id], :unique => true, :name => 'by_code'
    add_index :postal_codes, :postal_code_type_id
  end

  def self.down
    drop_table :postal_codes
  end
end