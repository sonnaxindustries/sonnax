require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PartAttribute do
  before(:each) do
    @part_attribute = Factory.build(:part_attribute)
  end

  it "should create a new instance given valid attributes" do
    @part_attribute.should be_valid
  end
end
