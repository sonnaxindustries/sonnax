require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LineItem do
  before(:each) do
    @line_item = Factory.build(:line_item)
  end

  it "should create a new instance given valid attributes" do
    @line_item.should be_valid
  end
  
  context 'Validations' do
    it "should not be valid without an order id" do
      @line_item.order_id = nil
      @line_item.should_not be_valid
    end
    
    it "should not be valid without a part id" do
      @line_item.part_id = nil
      @line_item.should_not be_valid
    end
    
    it "ensures uniqueness of part and order" do
      @line_item.save
      @old_line_item = @line_item
      @new_line_item = @old_line_item.clone
      @new_line_item.should_not be_valid
    end
  end
end