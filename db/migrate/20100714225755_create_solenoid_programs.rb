class CreateSolenoidPrograms < ActiveRecord::Migration
  def self.up
    create_table :solenoid_programs do |t|
      t.string :name, :null => false
      t.string :company, :null => false
      t.string :address, :null => false
      t.string :city, :null => false
      t.string :state, :null => false
      t.string :postal_code, :null => false
      t.string :phone, :null => false
      t.string :email
      t.string :fax
      t.integer :number_of_cores
      t.string :core_applications
      t.timestamps
    end
    
    add_index :solenoid_programs, :name
    add_index :solenoid_programs, :email
  end

  def self.down
    drop_table :solenoid_programs
  end
end
