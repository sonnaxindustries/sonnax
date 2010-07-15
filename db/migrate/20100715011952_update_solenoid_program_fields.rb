class UpdateSolenoidProgramFields < ActiveRecord::Migration
  def self.up
    change_column :solenoid_programs, :number_of_cores, :integer, :null => false
  end

  def self.down
    change_column :solenoid_programs, :number_of_cores, :integer
  end
end
