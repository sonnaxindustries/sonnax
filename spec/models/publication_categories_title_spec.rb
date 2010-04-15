require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PublicationCategoriesTitle do
  before(:each) do
    @publication_categories_title = Factory.build(:publication_categories_title)
  end

  it "should create a new instance given valid attributes" do
    @publication_categories_title.should be_valid
  end
end
