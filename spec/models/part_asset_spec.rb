require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PartAsset do
  before(:each) do
    @part_asset = Factory.build(:part_asset)
  end

  it "should create a new instance given valid attributes" do
    @part_asset.should be_valid
  end
  
  it "should not be valid without a part_id" do
    @part_asset.part_id = nil
    @part_asset.should_not be_valid
  end
  
  it "should not be valid without a part_asset_type_id" do
    @part_asset.part_asset_type_id = nil
    @part_asset.should_not be_valid
  end
  
  it "should not be valid without an asset_id" do
    @part_asset.asset_id = nil
    @part_asset.should_not be_valid
  end
  
  it "should not allow duplicate assets per part" do
    @part_asset.save
    @new_part_asset = @part_asset.clone
    @new_part_asset.should_not be_valid
  end
end
