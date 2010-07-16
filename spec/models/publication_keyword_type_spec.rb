require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PublicationKeywordType do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :description => "value for description",
      :sort_order => 1
    }
  end

  it "should create a new instance given valid attributes" do
    PublicationKeywordType.create!(@valid_attributes)
  end
end
