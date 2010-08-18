require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Order do
  before(:each) do
    @order = Factory.build(:order)
  end

  it "should create a new instance given valid attributes" do
    @order.should be_valid
  end
  
  it "should have available shipping methods" do
    Order::SHIPPING_METHODS.should_not be_empty
  end
  
  context 'Validations' do
    it "should not be valid without a name" do
      @order.name = nil
      @order.should_not be_valid
    end
    
    it "should not be valid without a company" do
      @order.company = nil
      @order.should_not be_valid
    end
    
    it "should not be valid without a postal code" do
      @order.postal_code = nil
      @order.should_not be_valid
    end
    
    it "should not be valid without an email address" do
      @order.email = nil
      @order.should_not be_valid
    end
  end
end
