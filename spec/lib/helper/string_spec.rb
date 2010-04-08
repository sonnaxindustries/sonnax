require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Helper::String do
  before(:each) do
    @string = 'This is a Test string'
  end
  
  it "should create a url friendly string" do
    @string.extend(Helper::String).to_url_friendly.should == 'this-is-a-test-string'
  end
  
  it "should create a key name from the string" do
    @string.extend(Helper::String).to_key_name.should == 'this_is_a_test_string'
  end
end
