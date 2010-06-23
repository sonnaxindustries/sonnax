require 'spec_helper'

describe PublicationTitlesMake do
  before(:each) do
    @valid_attributes = {
      :publication_title_id => 1,
      :make_id => 1,
      :sort_order => 1
    }
  end

  it "should create a new instance given valid attributes" do
    PublicationTitlesMake.create!(@valid_attributes)
  end
end
