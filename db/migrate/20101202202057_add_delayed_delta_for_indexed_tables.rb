class AddDelayedDeltaForIndexedTables < ActiveRecord::Migration
  def self.up
    [:makes, :units, :distributors, :parts, :publication_titles, :reference_figures, :product_lines, :unit_components].each do |tbl|
      add_column tbl, :delta, :boolean, :default => true, :null => false
    end
  end

  def self.down
    [:makes, :units, :distributors, :parts, :publication_titles, :reference_figures, :product_lines, :unit_components].each do |tbl|
      remove_column tbl, :delta
    end
  end
end
