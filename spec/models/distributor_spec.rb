require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Distributor do
  before(:each) do
    @distributor = Factory.build(:distributor)
  end

  it "should create a new instance given valid attributes" do
    @distributor.should be_valid
  end
end
