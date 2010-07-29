require File.expand_path(File.dirname(__FILE__) + '/../../../lib/helper/array')

describe Helper::Array do
  before(:each) do
    @array = []
  end
  
  it "should create a new conditions hash with one option" do
    @array << ['test_id = ?', 1]
    @array.extend(Helper::Array).to_conditions.should == ["test_id = ?", 1]
  end
  
  it "should flatten the array if there are no conditions provided" do
    @array << ['test_id = ?']
    @array.extend(Helper::Array).to_conditions.should == ["test_id = ?"]
  end
  
  it "should work with a mixture of options provided" do
    @array << ['test_id = ?', 1]
    @array << ['no_value = 0']
    @array.extend(Helper::Array).to_conditions.should == ["test_id = ? AND no_value = 0", 1]
  end
end