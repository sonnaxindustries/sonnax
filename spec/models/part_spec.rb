require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Part do
  before(:each) do
    @part = Factory.build(:part)
  end

  it "should create a new instance given valid attributes" do
    @part.should be_valid
  end
  
  it "should not be valid without a product line" do
    @part.product_line_id = nil
    @part.should_not be_valid
  end
  
  context 'Part Type' do
    before(:each) do
      Factory.build(:part_type).class.seeds #need to seed the data to make sure we can set the default
      @part_type = Factory.build(:part_type, :name => 'New Name')
    end
    
    it "should create a default part type on save" do
      @part.part_type_id = nil
      @part.save
      @part.part_type_id.should_not be_blank
    end
    
    it "should create a part type if given a valid part type" do
      @part.part_type = @part_type
      @part.save
      @part.part_type.name.should == 'New Name'
    end
  end
end
