require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Role do
  before(:each) do
    @role = Factory.build(:role)
  end

  it "should create a new instance given valid attributes" do
    @role.should be_valid
  end
end
