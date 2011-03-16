class AddAssetFieldsToPartsTable < ActiveRecord::Migration
  def self.up
    add_column :parts, :photo, :string
    add_column :parts, :announcement, :string
    add_column :parts, :instructions, :string
    add_column :parts, :tech, :string
    add_column :parts, :vbfix, :string
  end

  def self.down
    remove_column :parts, :photo
    remove_column :parts, :announcement
    remove_column :parts, :instructions
    remove_column :parts, :tech
    remove_column :parts, :vbfix
  end
end
