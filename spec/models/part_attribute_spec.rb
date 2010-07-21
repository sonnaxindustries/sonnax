require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PartAttribute do
  before(:each) do
    @part_attribute = Factory.build(:part_attribute)
  end

  it "should create a new instance given valid attributes" do
    @part_attribute.should be_valid
  end
  
  it "should not be valid without a part_id" do
    @part_attribute.part_id = nil
    @part_attribute.should_not be_valid
  end
  
  it "should not be valid without a part_attribute_type_id" do
    @part_attribute.part_attribute_type_id = nil
    @part_attribute.should_not be_valid
  end
  
  it "should not be valid without a value" do
    @part_attribute.attr_value = nil
    @part_attribute.should_not be_valid
  end
  
  it "should ensure uniqueness of the part and part attribute type" do
    @part_attribute.save
    @new_part_attribute = @part_attribute.clone
    @new_part_attribute.should_not be_valid
  end
end
