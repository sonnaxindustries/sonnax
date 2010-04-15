class CreatePostalCodeTypes < ActiveRecord::Migration
  def self.up
    create_table :postal_code_types do |t|
      t.string :name, :null => false, :limit => 100
      t.timestamps
    end
  end

  def self.down
    drop_table :postal_code_types
  end
end