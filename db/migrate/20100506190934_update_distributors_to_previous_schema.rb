class UpdateDistributorsToPreviousSchema < ActiveRecord::Migration
  def self.up
    add_column :distributors, :city, :string
    add_column :distributors, :state, :string
    add_column :distributors, :country, :string
    
    remove_column :distributors, :postal_code_id
    remove_column :distributors, :country_id
  end

  def self.down
    remove_column :distributors, :city
    remove_column :distributors, :state
    remove_column :distributors, :country
    
    add_column :distributors, :postal_code_id, :integer
    add_column :distributors, :country_id, :integer
  end
end