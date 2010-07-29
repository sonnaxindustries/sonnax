require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UnitComponent do
  before(:each) do
    @unit_component = Factory.build(:unit_component)
  end

  it "should create a new instance given valid attributes" do
    @unit_component.should be_valid
  end
  
  context 'Associations' do
    it "should respond to #part" do
      @unit_component.should respond_to(:part)
    end
  
    it "should respond to #unit" do
      @unit_component.should respond_to(:unit)
    end
  end
  
  context 'Validations' do
    it "should not be valid without a unit" do
      @unit_component.unit_id = nil
      @unit_component.should_not be_valid
    end
    
    it "should not be valid without a part" do
      @unit_component.part_id = nil
      @unit_component.should_not be_valid
    end
  end
end
