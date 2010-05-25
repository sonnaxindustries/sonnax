require 'spec_helper'

describe PublicationKeyword do
  before(:each) do
    @valid_attributes = {
      :publication_keyword_type_id => 1,
      :title => "value for title",
      :url_friendly => "value for url_friendly",
      :sort_order => 1
    }
  end

  it "should create a new instance given valid attributes" do
    PublicationKeyword.create!(@valid_attributes)
  end
end
