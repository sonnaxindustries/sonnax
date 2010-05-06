require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PartAttributeType do
  before(:each) do
    @part_attribute_type = Factory.build(:part_attribute_type)
  end

  it "should create a new instance given valid attributes" do
    @part_attribute_type.should be_valid
  end
end
