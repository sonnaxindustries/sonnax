require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CatalogFormat do
  before(:each) do
    @catalog_format = Factory.build(:catalog_format)
  end

  it "should create a new instance given valid attributes" do
    @catalog_format.should be_valid
  end
  
  it "should not be valid without a title" do
    @catalog_format.title = nil
    @catalog_format.should_not be_valid
  end
  
  it "should generate a URL friendly title from the title if none provided" do
    @catalog_format.title = 'Testing the Title'
    @catalog_format.url_friendly = nil
    @catalog_format.save
    @catalog_format.url_friendly.should == 'testing-the-title'
  end
end
