require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Country do
  before(:each) do
    @country = Factory.build(:country)
  end

  it "should create a new instance given valid attributes" do
    @factory.should be_valid
  end
end
