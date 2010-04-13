require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Make do
  before(:each) do
    @make = Factory.build(:make)
  end

  it "should create a new instance given valid attributes" do
    @make.should be_valid
  end
end
