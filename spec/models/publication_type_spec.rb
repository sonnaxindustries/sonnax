require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PublicationType do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :url_friendly => "value for url_friendly",
      :description => "value for description",
      :sort_order => 1
    }
  end

  it "should create a new instance given valid attributes" do
    PublicationType.create!(@valid_attributes)
  end
end
