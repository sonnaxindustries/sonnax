require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PartAssetType do
  before(:each) do
    @part_asset_type = Factory.build(:part_asset_type)
  end

  it "should create a new instance given valid attributes" do
    @part_asset_type.should be_valid
  end
  
  it "should not be valid without a name" do
    @part_asset_type.name = nil
    @part_asset_type.should_not be_valid
  end
  
  it "should generate a URL friendly name after creating" do
    @part_asset_type.name = 'New Name'
    @part_asset_type.url_friendly = nil
    @part_asset_type.save
    @part_asset_type.url_friendly.should == 'new-name'
  end
  
  it "should ensure the name is unique" do
    @part_asset_type.name = 'New Name'
    @part_asset_type.save
    @new_part_asset_type = @part_asset_type.clone
    @new_part_asset_type.should_not be_valid
  end
  
  it "should check equality based on name, case insensitive" do
    @part_asset_type.name = 'New Name'
    @part_asset_type.save
    @new_part_asset_type = @part_asset_type.clone
    @new_part_asset_type.name = 'new name'
    @new_part_asset_type.same_name?(@part_asset_type).should be_true
  end
  
  context 'Default Seeds' do
    before(:each) do
      @part_asset_type = Factory.build(:part_asset_type)
      @seeds = @part_asset_type.class.seeds
    end
    
    it "should contain 5 defaults" do
      @seeds.size.should == 5
    end
  end
end
