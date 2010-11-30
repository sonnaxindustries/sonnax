class AddHtmlContentToPublicationTitles < ActiveRecord::Migration
  def self.up
    add_column :publication_titles, :html_content, :text
  end

  def self.down
    remove_column :publication_titles, :html_content
  end
end
