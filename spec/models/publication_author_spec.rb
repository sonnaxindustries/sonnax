require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PublicationAuthor do
  before(:each) do
    @publication_author = Factory.build(:publication_author)
  end

  it "should create a new instance given valid attributes" do
    @publication_author.should be_valid
  end
end
