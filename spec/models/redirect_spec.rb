require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Redirect do
  before(:each) do
    @redirect = Factory.build(:redirect)
  end

  it "should create a new instance given valid attributes" do
    @redirect.should be_valid
  end
end