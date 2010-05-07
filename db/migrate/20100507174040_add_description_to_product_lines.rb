class AddDescriptionToProductLines < ActiveRecord::Migration
  def self.up
    add_column :product_lines, :description, :text
  end

  def self.down
    remove_column :product_lines, :description
  end
end