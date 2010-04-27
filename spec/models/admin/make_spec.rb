require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::Make do
  before(:each) do
    @make = Factory.build(:admin_make)
  end

  it "should create a new instance given valid attributes" do
    @make.should be_valid
  end
  
  it "should ensure a name is provided" do
    @make.name = nil
    @make.should_not be_valid
  end
  
  it "should ensure the name is unique" do
    @old_make = Factory.create(:admin_make, :name => 'Testing')
    @make.name = 'Testing'
    @make.should_not be_valid
  end
  
  it "should create a URL friendly title when creating" do
    @make.url_friendly = nil
    @make.save
    @make.url_friendly.should == 'honda'
  end
  
  it "should create a key name for later lookup" do
    @make.key_name = nil
    @make.save
    @make.key_name.should == 'honda'
  end
end