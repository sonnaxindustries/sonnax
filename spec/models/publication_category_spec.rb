require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PublicationCategory do
  before(:each) do
    @publication_category = Factory.build(:publication_category)
  end

  it "should create a new instance given valid attributes" do
    @publication_category.should be_valid
  end
end
