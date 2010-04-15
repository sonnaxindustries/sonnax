class CreatePublicationAuthors < ActiveRecord::Migration
  def self.up
    create_table :publication_authors do |t|
      t.string :first_name, :default => nil
      t.string :last_name, :default => nil
      t.string :full_name, :null => false
      t.text :bio
      t.timestamps
    end
  end

  def self.down
    drop_table :publication_authors
  end
end