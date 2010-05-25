class CreatePublicationTitlesSubjects < ActiveRecord::Migration
  def self.up
    create_table :publication_titles_subjects do |t|
      t.integer :publication_title_id, :null => false
      t.integer :publication_subject_id, :null => false
      t.integer :sort_order
      t.timestamps
    end
    
    add_index :publication_titles_subjects, :publication_title_id
    add_index :publication_titles_subjects, :publication_subject_id
    add_index :publication_titles_subjects, [:publication_title_id, :publication_subject_id], :unique => true, :name => 'by_subject'
  end

  def self.down
    drop_table :publication_titles_subjects
  end
end
