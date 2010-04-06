require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Redirect do
  before(:each) do
    @valid_attributes = {
      :old_url => "value for old_url",
      :new_url => "value for new_url",
      :http_code => "value for http_code"
    }
  end

  it "should create a new instance given valid attributes" do
    Redirect.create!(@valid_attributes)
  end
end
