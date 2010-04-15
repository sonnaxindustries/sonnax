require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PublicationTitlesAuthor do
  before(:each) do
    @publication_titles_author = Factory.build(:publication_titles_author)
  end

  it "should create a new instance given valid attributes" do
    @publication_titles_author.should be_valid
  end
end
