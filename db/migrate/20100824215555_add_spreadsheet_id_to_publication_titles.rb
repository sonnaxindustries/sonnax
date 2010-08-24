class AddSpreadsheetIdToPublicationTitles < ActiveRecord::Migration
  def self.up
    add_column :publication_titles, :spreadsheet_id, :integer, :after => :id
  end

  def self.down
    remove_column :publication_titles, :spreadsheet_id
  end
end
