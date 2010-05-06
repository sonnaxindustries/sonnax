require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Unit do
  before(:each) do
    @unit = Factory.build(:unit)
  end

  it "should create a new instance given valid attributes" do
    @unit.should be_valid
  end
end
