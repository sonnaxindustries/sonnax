require 'spec_helper'

describe Distributor do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :url_friendly => "value for url_friendly",
      :postal_code_id => 1,
      :country_id => 1,
      :phone_number => "value for phone_number",
      :website_url => "value for website_url"
    }
  end

  it "should create a new instance given valid attributes" do
    Distributor.create!(@valid_attributes)
  end
end
