class AddNotesAndItemToParts < ActiveRecord::Migration
  def self.up
    add_column :parts, :product_line_id, :integer, :null => false
    add_column :parts, :item, :text
    add_column :parts, :notes, :text
  end

  def self.down
    remove_column :parts, :product_line_id
    remove_column :parts, :item
    remove_column :parts, :notes
  end
end
