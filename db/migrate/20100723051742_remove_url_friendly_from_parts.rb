class RemoveUrlFriendlyFromParts < ActiveRecord::Migration
  def self.up
    remove_column :parts, :url_friendly
  end

  def self.down
    add_column :parts, :url_friendly, :string, :null => false
    add_index :parts, :url_friendly, :unique => true
  end
end
