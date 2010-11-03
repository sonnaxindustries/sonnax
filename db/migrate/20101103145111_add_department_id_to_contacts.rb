class AddDepartmentIdToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :department_id, :integer
  end

  def self.down
    remove_column :contacts, :department_id
  end
end
