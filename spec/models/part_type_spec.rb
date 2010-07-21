require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PartType do
  before(:each) do
    @part_type = Factory.build(:part_type)
  end

  it "should create a new instance given valid attributes" do
    @part_type.should be_valid
  end
  
  it "should not be valid without a name" do
    @part_type.name = nil
    @part_type.should_not be_valid
  end
  
  it "should have a default category of 'Uncategorized'" do
    @part_type.class::DEFAULT_TYPE_NAME.should == 'Uncategorized'
  end
  
  it "should create a URL friendly name before creation" do
    @part_type.name = 'Torque Converter'
    @part_type.save
    @part_type.url_friendly.should == 'torque-converter'
  end
  
  it "should ensure the name is unique" do
    @part_type.name = 'New Name'
    @part_type.save
    @new_part_type = @part_type.clone
    @new_part_type.should_not be_valid
  end
  
  context 'Default Seeds' do
    before(:each) do
      @part_type = Factory.build(:part_type)
      @seeds = @part_type.class.seeds
    end
    
    it "should contain 5 defaults" do
      @seeds.size.should == 1
    end
  end
end
