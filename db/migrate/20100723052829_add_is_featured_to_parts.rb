class AddIsFeaturedToParts < ActiveRecord::Migration
  def self.up
    add_column :parts, :is_featured, :boolean, :default => false
    add_index :parts, :is_featured
  end

  def self.down
    remove_column :parts, :is_featured
  end
end
