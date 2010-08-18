class AddCatalogsHashToCatalogRequests < ActiveRecord::Migration
  def self.up
    add_column :catalog_requests, :catalogs_hash, :text
  end

  def self.down
    remove_column :catalog_requests, :catalogs_hash
  end
end
