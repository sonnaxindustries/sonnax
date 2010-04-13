require 'spec_helper'

describe PostalCodeType do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :url_friendly => "value for url_friendly"
    }
  end

  it "should create a new instance given valid attributes" do
    PostalCodeType.create!(@valid_attributes)
  end
end
