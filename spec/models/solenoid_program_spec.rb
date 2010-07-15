require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SolenoidProgram do
  before(:each) do
    @solenoid_program = Factory.build(:solenoid_program)
  end

  it "should create a new instance given valid attributes" do
    @solenoid_program.should be_valid
  end
  
  it "should not be valid without a persons name" do
    @solenoid_program.name = nil
    @solenoid_program.should_not be_valid
  end
  
  it "should not be valid without a company" do
    @solenoid_program.company = nil
    @solenoid_program.should_not be_valid
  end
  
  it "should not be valid without an address" do
    @solenoid_program.address = nil
    @solenoid_program.should_not be_valid
  end
  
  it "should not be valid without a city" do
    @solenoid_program.city = nil
    @solenoid_program.should_not be_valid
  end
  
  it "should not be valid without a state" do
    @solenoid_program.state = nil
    @solenoid_program.should_not be_valid
  end
  
  it "should not be valid without a postal code" do
    @solenoid_program.postal_code = nil
    @solenoid_program.should_not be_valid
  end
  
  it "should not be valid without a phone number" do
    @solenoid_program.phone = nil
    @solenoid_program.should_not be_valid
  end
  
  it "should not be valid without a number of cores" do
    @solenoid_program.number_of_cores = nil
    @solenoid_program.should_not be_valid
  end
end
