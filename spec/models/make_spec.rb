require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Make do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :key_name => "value for key_name",
      :url_friendly => "value for url_friendly"
    }
  end

  it "should create a new instance given valid attributes" do
    Make.create!(@valid_attributes)
  end
end
