require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProductLinePart do
  before(:each) do
    @product_line_part = Factory.build(:product_line_part)
  end

  it "should create a new instance given valid attributes" do
    @product_line_part.should be_valid
  end
  
  it "should not be valid without a product line" do
    @product_line_part.product_line_id = nil
    @product_line_part.should_not be_valid
  end
  
  it "should not be valid without a part" do
    @product_line_part.part_id = nil
    @product_line_part.should_not be_valid
  end
  
  it "should ensure unique part and product line" do
    @product_line_part.save
    @new_product_line_part = @product_line_part.clone
    @new_product_line_part.should_not be_valid
  end
  
  context 'Marking as Featured' do
    it "should be able to mark as featured" do
      @product_line_part.should respond_to(:mark_as_featured!)
    end
    
    it "should mark a part as featured" do
      @product_line_part.mark_as_featured!
      @product_line_part.is_featured.should be_true
    end
    
    it "should return 1 record for featured in a product line" do
      @product_line_part.is_featured = true
      @product_line_part.save
      @featured = @product_line_part.class.featured_for_product_line(@product_line_part.product_line_id)
      @featured.size.should == 1
    end
    
    it "should return return true for #previous_featured?" do
      @product_line_part.product_line_id = 3
      @product_line_part.is_featured = true
      @product_line_part.save
      @new_product_line = Factory.build(:product_line_part, :part_id => 34, :product_line_id => 3)
      @new_product_line.should be_previous_featured
    end
    
    it "should ensure there is only 1 featured part per product line" do
      @p1 = Factory.create(:product_line_part, :product_line_id => 3, :part_id => 1, :is_featured => false)
      @p1.mark_as_featured!
      @p2 = Factory.create(:product_line_part, :product_line_id => 3, :part_id => 2, :is_featured => false)
      @p2.mark_as_featured!
      @p1.reload
      @p2.reload
      @p1.should_not be_featured
    end
    
    it "should return true for #featured?" do
      @product_line_part.is_featured = true
      @product_line_part.should be_featured
    end
  end
end
