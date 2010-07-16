require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PublicationTitlesType do
  before(:each) do
    @valid_attributes = {
      :publication_title_id => 1,
      :publication_type_id => 1,
      :sort_order => 1
    }
  end

  it "should create a new instance given valid attributes" do
    PublicationTitlesType.create!(@valid_attributes)
  end
end
