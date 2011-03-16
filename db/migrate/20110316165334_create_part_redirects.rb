class CreatePartRedirects < ActiveRecord::Migration
  def self.up
    create_table :part_redirects do |t|
      t.integer :old_part_id, :null => false
      t.integer :part_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :part_redirects
  end
end
