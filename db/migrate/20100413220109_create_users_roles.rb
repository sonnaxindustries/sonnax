class CreateUsersRoles < ActiveRecord::Migration
  def self.up
    create_table :users_roles do |t|
      t.integer :user_id, :null => false
      t.integer :role_id, :null => false
    end
    
    add_index :users_roles, :user_id
    add_index :users_roles, :role_id
    add_index :users_roles, [:user_id, :role_id], :unique => true, :name => 'by_role'
  end

  def self.down
    drop_table :users_roles
  end
end