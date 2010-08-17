require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CatalogRequest do
  before(:each) do
    @catalog_request = Factory.build(:catalog_request, :catalogs => [1])
  end

  it "should create a new instance given valid attributes" do
    @catalog_request.should be_valid
  end
  
  it "should contain at least 1 catalog" do
    CatalogRequest.catalogs.should_not be_empty
  end
  
  context 'Validations' do
    it "should not be valid without a name" do
      @catalog_request.name = nil
      @catalog_request.should_not be_valid
    end
    
    it "should not be valid without a company" do
      @catalog_request.company = nil
      @catalog_request.should_not be_valid
    end
    
    it "should not be valid without a type of business" do
      @catalog_request.type_of_business = nil
      @catalog_request.should_not be_valid
    end
    
    it "should not be valid without an address" do
      @catalog_request.address = nil
      @catalog_request.should_not be_valid
    end
    
    it "should not be valid without a city" do
      @catalog_request.city = nil
      @catalog_request.should_not be_valid
    end
    
    it "should not be valid without a state" do
      @catalog_request.state = nil
      @catalog_request.should_not be_valid
    end
    
    it "should not be valid without a postal code" do
      @catalog_request.postal_code = nil
      @catalog_request.should_not be_valid
    end
    
    it "should not be valid without a country" do
      @catalog_request.country = nil
      @catalog_request.should_not be_valid
    end
    
    it "should not be valid without a phone number" do
      @catalog_request.phone_number = nil
      @catalog_request.should_not be_valid
    end
    
    it "should not be valid without an email address" do
      @catalog_request.email_address = nil
      @catalog_request.should_not be_valid
    end
    
    it "should not be valid without at least 1 catalog selected" do
      @catalog_request.catalogs = []
      @catalog_request.should_not be_valid
    end
  end
end
