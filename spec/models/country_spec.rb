require 'spec_helper'

describe Country do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :url_friendly => "value for url_friendly",
      :code => "value for code",
      :flag_file_name => "value for flag_file_name",
      :flag_file_size => 1,
      :flag_content_type => "value for flag_content_type",
      :flag_updated_at => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Country.create!(@valid_attributes)
  end
end
