require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ReferenceFigure do
  before(:each) do
    @reference_figure = Factory.build(:reference_figure)
  end

  it "should create a new instance given valid attributes" do
    @reference_figure.should be_valid
  end
end
