require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProductLine do
  before(:each) do
    @product_line = Factory.build(:product_line)
  end

  it "should create a new instance given valid attributes" do
    @product_line.should be_valid
  end
end
