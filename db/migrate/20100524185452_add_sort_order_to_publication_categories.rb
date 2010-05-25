class AddSortOrderToPublicationCategories < ActiveRecord::Migration
  def self.up
    add_column :publication_categories, :sort_order, :integer
  end

  def self.down
    remove_column :publication_categories, :sort_order
  end
end
