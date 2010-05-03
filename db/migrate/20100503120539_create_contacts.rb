class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :name, :null => false
      t.string :email, :null => false
      t.string :company, :null => false
      t.string :phone_number, :null => false
      t.text :message, :null => false
      t.timestamps
    end
    
    add_index :contacts, :email
  end

  def self.down
    drop_table :contacts
  end
end