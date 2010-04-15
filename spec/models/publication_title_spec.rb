require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PublicationTitle do
  before(:each) do
    @publication_title = Factory.build(:publication_title)
  end

  it "should create a new instance given valid attributes" do
    @publication_title.should be_valid
  end
end