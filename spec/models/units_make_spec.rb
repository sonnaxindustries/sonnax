require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UnitsMake do
  before(:each) do
    @units_make = Factory.build(:units_make)
  end

  it "should create a new instance given valid attributes" do
    @units_make.should be_valid
  end
end
