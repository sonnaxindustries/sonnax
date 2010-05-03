require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Contact do
  before(:each) do
    @contact = Factory.build(:contact)
  end

  it "should create a new instance given valid attributes" do
    @contact.should be_valid
  end
  
  it "should not be valid without a name" do
    @contact.name = nil
    @contact.should_not be_valid
  end
  
  it "should not be valid without an email" do
    @contact.email = nil
    @contact.should_not be_valid
  end
  
  context "With an email address" do
    it "should not be valid with a malformed email address" do
      @contact.email = 'invalid'
      @contact.should_not be_valid
    end
  end
  
  it "should not be valid without a company name" do
    @contact.company = nil
    @contact.should_not be_valid
  end
  
  it "should not be valid without a phone number" do
    @contact.phone_number = nil
    @contact.should_not be_valid
  end
  
  it "should not be valid without a message" do
    @contact.message = nil
    @contact.should_not be_valid
  end
end
