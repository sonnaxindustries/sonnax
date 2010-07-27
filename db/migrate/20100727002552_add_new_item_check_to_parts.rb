class AddNewItemCheckToParts < ActiveRecord::Migration
  def self.up
    add_column :parts, :is_new_item, :boolean, :default => false
  end

  def self.down
    remove_column :parts, :is_new_item
  end
end
